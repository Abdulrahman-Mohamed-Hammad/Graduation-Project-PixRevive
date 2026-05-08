import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pix_revive/core/api/dio_client.dart';

import 'package:pix_revive/core/App/auth/data/model/auth_model.dart';

class AuthApi {
  static Future<Either<String, Response<dynamic>>> requestServer(
    String path,
    Auth model,
  ) async {
    try {
      var response = await Api.post(path, data: model.toJson());
      return right(response);
    } on DioException catch (e) {
      log(e.response.toString());
      if (e.type == DioExceptionType.connectionError) {
        return left("No Internet connection");
      }
      return left(" ERRor");
    }
  }
}
