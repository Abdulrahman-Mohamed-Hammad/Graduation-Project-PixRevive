import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pix_revive/feature/Auth/Screens/ForgotPassword/forgot_screen.dart';
import 'package:pix_revive/feature/Auth/Screens/controller/auth_controller_screen.dart';
import 'package:pix_revive/feature/Splash/page/splash_screen.dart';

class KRoutes {
  static String splash = "/";
  static String authControllerScreen = "/authControllerScreen";
  static String forgotPassword = "/forgotPassword";

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
