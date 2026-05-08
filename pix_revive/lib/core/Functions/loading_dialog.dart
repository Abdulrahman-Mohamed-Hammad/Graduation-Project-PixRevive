import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pix_revive/core/constants/app_icons.dart';

loadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Lottie.asset(Kicon.dotsWave, width: 100, height: 100),
    ),
  );
}
