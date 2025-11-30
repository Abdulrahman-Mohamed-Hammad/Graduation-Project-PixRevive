import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubitState {}

class InitialState extends AppCubitState {}

class NextPageState extends AppCubitState {
  NextPageState({required this.index});
  int index;
}

class FilterRebuildState extends AppCubitState {}

class ReversePageState extends AppCubitState {}

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(InitialState());
  FilterModel filterModel = FilterModel();

  void changeFilter() {
    emit(FilterRebuildState());
  }

  void nextPage(int index) {
    emit(NextPageState(index: index));
  }

  void reversePage() {
    emit(ReversePageState());
  }
}

class FilterModel {
  double brightness;
  double contrast;

  FilterModel({this.brightness = 0, this.contrast = 0});
}
