import 'package:flutter/material.dart';
import 'package:pix_revive/Utils/constant_color.dart';
import 'package:pix_revive/Utils/constant_font.dart';
import 'package:pix_revive/routes/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      go(context, KRoutes.authControllerScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pix", style: Kfont.semiBold48),
            Text(
              "Revive",
              style: Kfont.semiBold48.copyWith(color: Kcolor.mainColor),
            ),
          ],
        ),
      ),
    );
  }
}
