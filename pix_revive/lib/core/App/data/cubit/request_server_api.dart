import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pix_revive/core/App/SharedPreferences/shared_preferences.dart';
import 'package:pix_revive/core/api/dio_client.dart';

class RequestServerApp {
  static Future<Either<int?, Response<dynamic>>> getHistoryData(
    String token,
  ) async {
    try {
      var response = await Api.get(
        Endpoints.history,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      log("History data: ${response.data}");
      return Right(response);
    } on DioException catch (e) {
      log("errrrrrrrrrrrrrrror: ${e.response?.statusCode}");
      return Left(e.response?.statusCode);
    }
  }

  static Future<String?> getNewAccessToken() async {
    try {
      var response = await Api.post(
        Endpoints.continueWithGoogle,
        data: {
          "refresh": SharedPreferencesHelper.getString(
            KSharedPreferencesKeys.refreshtoken,
          )!,
        },
      );
      var newAccessToken = response.data["access"];
      SharedPreferencesHelper.setString(
        KSharedPreferencesKeys.accsesstoken,
        newAccessToken,
      );
      return newAccessToken;
    } catch (e) {
      return null;
    }
  }

  static Future<int?> uploadImageInServer(
    String path,
    FormData formData,
    String token,
  ) async {
    try {
      var response = await Api.post(
        path,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      log("Upload response: ${response.data}");
      return response.statusCode;
    } on DioException catch (e) {
      return e.response?.data["error"];
    }
  }

  static Future<Either<String?, Response<dynamic>>> useAi(
    String path,
    FormData formData,
    String token,
  ) async {
    try {
      var response = await Api.post(
        path,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      log("Upload response: ${response.data}");
      return Right(response);
    } on DioException catch (e) {
      log("Upload error: ${e.response?.statusCode}");
      log("Upload error headers: ${e.response?.headers}");
      log("Upload error data: ${e.response?.data}");
      return Left(e.response?.data["message"]);
    }
  }




  Future<String?>getTokenApiKey()async{
    try{
     var response = await Api.post(Endpoints.getTokenPaymob,data: {
        "api_key":Endpoints.apiKey});
        if(response.statusCode==200 || response.statusCode==201){
          return response.data["api_key"];
        }
     return "";
    } catch (e) {
      return null;
    }

  }

    Future<String?>getOrderId(String token)async{
      try{
      var response = await Api.post(Endpoints.requestOrderPaymob,data: {
          "amount_cents": 1000,
          "currency": "EGP",
          "items": [
            {
              "name": "item1",
              "amount_cents": 1000,
              "quantity": 1
            }
          ]
        },options: Options(headers: {"Authorization": "Bearer $token"}));
          if(response.statusCode==200 || response.statusCode==201){
            return response.data["id"].toString();
          }
      return "";
      } catch (e) {
        return null;
      }
  
    }
}
