import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pix_revive/core/App/SharedPreferences/shared_preferences.dart';
import 'package:pix_revive/core/FireBase/firebase.dart';
import 'package:pix_revive/core/constants/app_colors.dart';

import 'package:pix_revive/core/router/go_router.dart';
import 'package:pix_revive/core/api/dio_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseProvider.init();
  await SharedPreferencesHelper.init();

  Api.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: Kcolor.white,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,

          color: Colors.transparent,
          elevation: 0,
        ),
      ),
      routerConfig: KRoutes.routes,

      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Transparent bar
          statusBarIconBrightness: Brightness.dark, // Android: Black icons
          statusBarBrightness: Brightness.light, // iOS: Black icons
        ),
        child: MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(boldText: false, textScaler: TextScaler.noScaling),
          child: child!,
        ),
      ),
    );
  }
}
