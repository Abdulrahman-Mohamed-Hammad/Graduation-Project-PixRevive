import 'package:image_picker/image_picker.dart';

class AppCubitState {}

class InitialState extends AppCubitState {}

class NextPageState extends AppCubitState {
  NextPageState({required this.index});
  int index;
}

class LoadingState extends AppCubitState {}

class LoadingStateAi extends AppCubitState {}

class Finish extends AppCubitState {
  Finish(this.image);
  XFile? image;
}

class ErrorState extends AppCubitState {
  String message;
  ErrorState({required this.message});
}

class SuccessState extends AppCubitState {}

class FailedToAccessNewToken extends AppCubitState {}

class FilterRebuildState extends AppCubitState {}

class ReversePageState extends AppCubitState {}
