import 'package:flutter/material.dart';
import 'package:pix_revive/core/constants/app_colors.dart';

import 'package:pix_revive/core/router/go_router.dart';
import 'package:pix_revive/data/services/api/dio_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Api.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: Kcolor.backgroundColor),
      routerConfig: KRoutes.routes,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(boldText: false, textScaler: TextScaler.noScaling),
        child: child!,
      ),
    );
  }
}
