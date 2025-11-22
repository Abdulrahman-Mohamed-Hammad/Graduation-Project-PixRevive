import 'package:dio/dio.dart';

class Endpoints {
  static const baseUrl = "https://apipix-production-a562.up.railway.app";
  static const login = "/api/users/login/";
  static const register = "/api/users/register/";
  static const forgotPassword = "/api/users/password/reset/request/";
  static const resetPassword = "/api/users/password/reset/";
}

class Api {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl));
  }

  static Future<Response<dynamic>> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  static Future<Response<dynamic>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
