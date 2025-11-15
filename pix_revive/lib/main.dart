import 'package:flutter/material.dart';
import 'package:pix_revive/Utils/constant_color.dart';
import 'package:pix_revive/routes/go_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: Kcolor.white),
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
