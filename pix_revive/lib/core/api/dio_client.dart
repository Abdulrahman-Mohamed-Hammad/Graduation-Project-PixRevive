import 'package:dio/dio.dart';

class Endpoints {
  static const baseUrl = "https://project-3-production-0259.up.railway.app";
  static const login = "/api/users/login/";
  static const register = "/api/users/register/";
  static const requestResetPassword = "/api/users/password/reset/request/";
  static const resetPassword = "/api/users/password/reset/";
  static const continueWithGoogle = "/api/users/continue-google/";
  static const verifyEmail = "/api/users/verify/";

  static const history = "/api/history/";
  static const getNewAccsessToken = "/api/users/refresh/";
  static const uploadImage = "/api/processing/process/";
  static const uploadImageSaveHistory = "/api/processing/save/";


  static const apiKey ="ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRFMk1UWTFOaXdpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5pU3Y0NWRXMi1JZGh3T3J2ZVpMRGNrbURkZWkxcG9pYWNfMkQyenFZcXR5MWhnd2RDRE5EeU9BR0NOOHFxQzFDZ2lMNk1qXy1OZDlfQ25mUU10Vnktdw==";
  static const getTokenPaymob ="https://accept.paymob.com/api/auth/tokens";
  static const requestOrderPaymob ="https://accept.paymob.com/api/ecommerce/orders";
  static const paymentKey ="https://accept.paymob.com/api/acceptance/payment_keys";
 
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
