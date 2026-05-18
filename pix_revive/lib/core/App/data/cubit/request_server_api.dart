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

  static Future<String?> getNewAccessToken(String token) async {
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




 static Future<String?>getTokenApiKey()async{
    try{
     var response = await Api.post(Endpoints.getTokenPaymob,data: {
        "api_key":Endpoints.apiKey});
        if(response.statusCode==200 || response.statusCode==201){
          return response.data["token"];
        }
     return "";
    } catch (e) {
      return null;
    }

  }

 static   Future<String?>getOrderId(String token)async{
      try{
      var response = await Api.post(Endpoints.requestOrderPaymob,data: {
          "amount_cents": 26700,
          "currency": "USD",
          "items": [
           
          ],
         
        },options: Options(headers: {"Authorization": "Bearer $token"}));
          if(response.statusCode==200 || response.statusCode==201){
            return response.data["id"].toString();
          }
      return "";
      } catch (e) {
        return null;
      }
  
    }
 static   Future<String?> getPaymentKey({
  required String authToken,
  required String orderId,
  required String amountInCents,
}) async {
  try {
    var response = await Api.post(
      Endpoints.paymentKey,
      data: {
        "auth_token": authToken,
        "amount_cents": amountInCents,
        "expiration": 3600, // Token valid for 1 hour
        "order_id": orderId,
        "billing_data": {
          "first_name": SharedPreferencesHelper.getString(KSharedPreferencesKeys.username) ?? "Test",
          "last_name": "Developer",
           "email": SharedPreferencesHelper.getString(KSharedPreferencesKeys.email),
          "phone_number": "+201000000000", // The dummy number
          "apartment": "NA",
          "floor": "NA",
          "street": "NA",
          "building": "NA",
          "city": "Alexandria",
          "country": "EG",
          "shipping_method": "NA",
        },
        "currency": "EGP",
        "integration_id": 5658071, // REPLACE THIS WITH YOUR CARD INTEGRATION ID
      },
    );

    if (response.statusCode == 201) {
      return response.data["token"]; // This is the final token for the Iframe
    }
  } catch (e) {
    print("Payment Key Error: $e");
  }
  return null;
}
}
