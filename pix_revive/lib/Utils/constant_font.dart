import 'package:flutter/material.dart';
import 'package:pix_revive/Utils/constant_color.dart';

class Kfont {
  // static const family = "Montserrat";
  static const family = "Inter_18";

  static const TextStyle semiBold48 = TextStyle(
    fontSize: 48,
    color: Kcolor.gray,
    fontFamily: Kfont.family,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle meduim16 = TextStyle(
    fontSize: 16,
    color: Kcolor.titleColor,
    fontFamily: Kfont.family,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle regular16 = TextStyle(
    fontSize: 16,
    color: Kcolor.subtitleText,
    fontFamily: Kfont.family,
    fontWeight: FontWeight.w400,
  );
}
