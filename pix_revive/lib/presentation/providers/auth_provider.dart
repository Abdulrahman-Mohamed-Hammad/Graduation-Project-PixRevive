import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_revive/data/services/api/dio_client.dart';

class AuthCubitState {}

class InitState extends AuthCubitState {}

class LoadingState extends AuthCubitState {}

class ErrorState extends AuthCubitState {}

class SuccsessState extends AuthCubitState {}

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(InitState());
  final userNameController = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();

  loginAndRegiter(String path, AuthModel model) async {
    emit(LoadingState());
    var response = await AuthApi.requestServer(path, model);
    response.fold(
      (left) => emit(ErrorState()),
      (right) => emit(SuccsessState()),
    );
  }
}

class AuthApi {
  static Future<Either<String, Response<dynamic>>> requestServer(
    String path,
    AuthModel model,
  ) async {
    try {
      var response = await Api.post(path, data: model.toJson());
      return right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return left("No Internet connection");
      }
      return left(e.response!.data["detail"]?[0] ?? " ERRor");
    }
  }
}

class AuthModel {
  String? userName;
  String? email;
  String? password;
  String? confirmpassword;
  AuthModel({this.userName, this.email, this.password, this.confirmpassword});

  Map<String, dynamic> toJson() {
    return {
      "username": userName,
      "email": email,
      "password": password,
      "password_confirm": confirmpassword,
    };
  }
}
