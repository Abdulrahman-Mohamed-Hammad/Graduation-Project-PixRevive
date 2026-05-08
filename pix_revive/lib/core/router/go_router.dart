import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pix_revive/core/App/auth/data/model/auth_model.dart';
import 'package:pix_revive/core/App/screen/Subscritption.dart';
import 'package:pix_revive/core/App/screen/controller-page_navbar.dart';
import 'package:pix_revive/core/App/screen/saved_image_screen.dart';
import 'package:pix_revive/core/App/auth/Screen/verfication_screen.dart';
import 'package:pix_revive/core/App/auth/data/cubit/Auth_cubit.dart';
import 'package:pix_revive/core/App/data/cubit/app_cubit.dart';
import 'package:pix_revive/core/App/auth/Screen/auth_controller.dart';
import 'package:pix_revive/core/App/auth/Screen/forgot_password_screen.dart';
import 'package:pix_revive/core/App/auth/Screen/reset_password.dart';
import 'package:pix_revive/core/App/screen/enhance-images.dart';
import 'package:pix_revive/core/App/screen/splash_screen.dart';

class KRoutes {
  static String splash = "/";
  static String authControllerScreen = "/authControllerScreen";
  static String forgotPassword = "/forgotPassword";
  static String resetPassword = "/ResetPassword";
  static String verifyEmail = "/verifyEmail";
  static String navbar = "/navbar";
  static String home = "/Home";
  static String enhanceImages = "/enhanceImages";
  static String saved = "/saved";
  static String subscritptionPlan = "/subscritptionPlan";

  static var routes = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),

      GoRoute(
        path: authControllerScreen,
        builder: (context, state) => AuthControllerScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
          child: ForgotPassword(),
        ),
      ),
      GoRoute(
        path: verifyEmail,
        builder: (context, state) => BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
          child: VerificationScreen(email: state.extra as String),
        ),
      ),

      GoRoute(
        path: resetPassword,
        builder: (context, state) => BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
          child: FocusScope(child: ResetPassword(email: state.extra as String)),
        ),
      ),

      ShellRoute(
        builder: (context, state, child) => BlocProvider<AppCubit>(
          create: (context) => AppCubit(),
          child: child,
        ),
        routes: [
          GoRoute(
            path: navbar,
            builder: (context, state) => NavbarApp(name: state.extra as String),
          ),
          GoRoute(
            path: navbar,
            builder: (context, state) => SubscritptionPlan(),
          ),
          GoRoute(
            path: enhanceImages,
            builder: (context, state) => BlocProvider<AppCubit>(
              create: (context) => AppCubit(),
              child: EnhanceImages(images: state.extra as List<XFile>),
            ),
          ),
          GoRoute(
            path: subscritptionPlan,
            builder: (context, state) => SubscritptionPlan(),
          ),
        ],
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
