import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_revive/core/App/SharedPreferences/shared_preferences.dart';
import 'package:pix_revive/core/App/auth/data/repo/response_login_register/response_login_register.dart';
import 'package:pix_revive/core/FireBase/firebase.dart';
import 'package:pix_revive/core/api/dio_client.dart';
import 'package:pix_revive/core/App/auth/data/cubit/cubit_state.dart';
import 'package:pix_revive/core/App/auth/data/model/auth_model.dart';
import 'package:pix_revive/core/App/auth/data/repo/auth_api.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(InitState());
  final focusNode = FocusNode();
  final userNameController = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  final otp = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ResponseLoginRegister? responseLoginRegister;

 Future<void> loginAndRegiter(String path, Auth model) async {
    emit(LoadingState());
    var response = await AuthApi.requestServer(path, model);
    response.fold((left) => emit(ErrorState("Invalid Email or Password")), (
      right,
    ) {
      responseLoginRegister = ResponseLoginRegister.fromJson(right.data);
      log( "Login/Register Response: ${responseLoginRegister?.toJson()}");
      SharedPreferencesHelper.setString(
        KSharedPreferencesKeys.username,
        responseLoginRegister!.user?.username! ?? "",
      );
      SharedPreferencesHelper.setString(
        KSharedPreferencesKeys.accsesstoken,
        responseLoginRegister!.tokens!.access!,
      );
      SharedPreferencesHelper.setString(
        KSharedPreferencesKeys.email,
        responseLoginRegister!.user?.email! ?? "",
      );
      SharedPreferencesHelper.setString(
        KSharedPreferencesKeys.refreshtoken,
        responseLoginRegister!.tokens!.refresh!,
      );

      emit(SuccsessState());
      log("Login successful ${responseLoginRegister?.user?.email}");
    });
  }

  Future<void> loginWithGoogle() async {
    var response = await FirebaseProvider.signInwithGoogle();
    if (response != null) {
    await loginAndRegiter(
        Endpoints.continueWithGoogle,
        AuthGoogleModel(email: response.email, googleId: response.id),
      );
    }
  }

  Future<void> requestResetPassword(
    String path,
    Auth model, [
    bool showLoading = true,
  ]) async {
    if (showLoading) emit(LoadingState());

    var response = await AuthApi.requestServer(path, model);
    response.fold(
      (left) {
        emit(ErrorState("Invalid Email"));
      },
      (right) {
        if (showLoading) emit(SuccsessState());
      },
    );
  }

  Future<void> verifyEmail(Auth model) async {
    emit(LoadingState());
    var response = await AuthApi.requestServer(Endpoints.verifyEmail, model);
    response.fold(
      (left) {
        emit(ErrorState("Invalid Data"));
      },
      (right) {
        emit(SuccsessState());
      },
    );
  }

  // requestResetPassword(String path, Auth model) async {
  //   emit(LoadingState());

  //   var response = await AuthApi.requestServer(path, model);
  //   response.fold(
  //     (left) {
  //       emit(ErrorState());
  //     },
  //     (right) {
  //       emit(SuccsessState());
  //     },
  //   );
  // }
}
