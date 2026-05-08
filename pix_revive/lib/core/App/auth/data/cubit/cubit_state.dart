class AuthCubitState {}

class InitState extends AuthCubitState {}

class LoadingState extends AuthCubitState {}

class ErrorState extends AuthCubitState {
  ErrorState(this.message);
  final String message;
}

class SuccsessState extends AuthCubitState {}
