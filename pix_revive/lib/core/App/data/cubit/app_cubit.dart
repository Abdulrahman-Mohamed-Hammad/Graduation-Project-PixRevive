import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pix_revive/core/App/SharedPreferences/shared_preferences.dart';
import 'package:pix_revive/core/App/data/cubit/cubit_state.dart';
import 'package:pix_revive/core/App/data/cubit/request_server_api.dart';
import 'package:pix_revive/core/App/data/model/filter_model.dart';
import 'package:pix_revive/core/App/data/repo/response_history/response_history.dart';
import 'package:pix_revive/core/App/screen/enhance-images.dart';
import 'package:pix_revive/core/api/dio_client.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(InitialState());
  FilterModel filterModel = FilterModel();
  List<ResponseHistory?> responseHistory = [];
  ResponseHistory? responseAIimage;
  int indexFeature = 0;
  bool secoundy = false;
  bool apply = true;
  String? orderID;

  Future<void> saveInGallery(XFile image, int rotate, AppCubit cubit) async {
    emit(LoadingState());
    await saveIMageinGallery(image, rotate, cubit);
    await uploadImageInServer(
      Endpoints.uploadImageSaveHistory,
      image,
      cubit: cubit,
      loading: false,
    );

    emit(SuccessState());
  }

  String? getAccessToken() {
    return SharedPreferencesHelper.getString(
      KSharedPreferencesKeys.accsesstoken,
    );
  }

  Future<String?> payment() async {
   emit(LoadingState());
   log(SharedPreferencesHelper.getString(KSharedPreferencesKeys.email) ?? "no email");
    var key = await RequestServerApp.getTokenApiKey();
     log( "1");
    if(key != null && key.isNotEmpty){
      var orderId = await RequestServerApp.getOrderId(key);
      log( "2");
      if(orderId != null && orderId.isNotEmpty){
        orderID = orderId;
         log( "3");
        var paymentKey = await RequestServerApp.getPaymentKey(
          authToken: key,
          orderId: orderId,
          amountInCents: 26700.toString(),
        );
        if(paymentKey != null && paymentKey.isNotEmpty){
          emit(SuccessState());
          log( "Payment key: $paymentKey");
          return paymentKey;
        }
          return null;
        
    }
    }
  }

  Future<void> getHistory() async {
    // emit(LoadingState());
    var response = await RequestServerApp.getHistoryData(getAccessToken()  ?? "");
    await response.fold(
      (left) async {
        if (left == 401) {
          await SharedPreferencesHelper.removeKey(
            KSharedPreferencesKeys.accsesstoken,
          );

          var response = await RequestServerApp.getNewAccessToken(SharedPreferencesHelper.getString(KSharedPreferencesKeys.refreshtoken)?? "");
          if (response != null) {
            await SharedPreferencesHelper.setString(
              KSharedPreferencesKeys.accsesstoken,
              response,
            );

            return;
          }
          log("Failed to access new token, user needs to log in again");
          emit(FailedToAccessNewToken());
          return;
        }
      },
      (right) {
        responseHistory = (right.data as List)
            .map<ResponseHistory?>((item) => ResponseHistory.fromJson(item))
            .toList();
        log("History data: ${responseHistory.length} items");
        emit(SuccessState());
      },
    );
  }

  Future<XFile> urlToXFile(String url) async {
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/temp_image.jpg';

    await Dio().download(url, filePath);

    return XFile(filePath);
  }

  Future<void> uploadImageInServer(
    String path,
    XFile image, {
    String? feature,
    int? rotate,
    AppCubit? cubit,
    bool loading = false,
  }) async {
    if (loading) emit(LoadingStateAi());

    //  image = await imageToXFile(image, rotate,cubit);
    var response = await RequestServerApp.useAi(
      path,
      FormData.fromMap({
        "image": await MultipartFile.fromFile(
          // ✅ convert to MultipartFile
          image.path,
          filename: image.name,
        ),
        "feature": feature,
      }),
      getAccessToken()!,
    );

    await response.fold(
      (left) {
        emit(ErrorState(message: left.toString()));
      },
      (right) async {
        if (loading) {
          responseAIimage = ResponseHistory.fromJsonAi(right.data);
          var newimage = await urlToXFile(responseAIimage?.restoredImage ?? "");

          log(right.data.toString());
          if (loading) emit(Finish(newimage));
        }
      },
    );
    emit(FilterRebuildState());
  }

  void changeFilter() {
    emit(FilterRebuildState());
  }

  void nextPage(int index) {
    emit(NextPageState(index: index));
  }

  void reversePage() {
    emit(ReversePageState());
  }

  void emitSuccsess() {
    emit(SuccessState());
  }

  void emitInitial() {
    emit(InitialState());
  }
}
