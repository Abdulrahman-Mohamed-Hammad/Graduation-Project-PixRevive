import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pix_revive/presentation/providers/auth_controller.dart';
import 'package:pix_revive/presentation/screens/auth/forgot_password_screen.dart';
import 'package:pix_revive/presentation/screens/auth/reset_password.dart';
import 'package:pix_revive/presentation/screens/home/home_screen.dart';
import 'package:pix_revive/presentation/screens/splash/splash_screen.dart';

class KRoutes {
  static String splash = "/";
  static String authControllerScreen = "/authControllerScreen";
  static String forgotPassword = "/forgotPassword";
  static String resetPassword = "/ResetPassword";
  static String home = "/Home";

  static var routes = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: authControllerScreen,
        builder: (context, state) => AuthControllerScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => ForgotPassword(),
      ),
      GoRoute(path: home, builder: (context, state) => Home()),
      GoRoute(
        path: resetPassword,
        builder: (context, state) => ResetPassword(),
      ),
    ],
  );
}

void push(BuildContext context, String path, {Object? extra}) {
  context.push(path, extra: extra);
}

void pushReplacement(BuildContext context, String path, {Object? extra}) {
  context.pushReplacement(path, extra: extra);
}

void go(BuildContext context, String path, {Object? extra}) {
  context.go(path, extra: extra);
}

void pop(BuildContext context) {
  context.pop();
}
