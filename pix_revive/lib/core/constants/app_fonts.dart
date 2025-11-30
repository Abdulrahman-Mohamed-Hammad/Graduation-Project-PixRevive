import 'package:flutter/material.dart';

import 'package:pix_revive/core/constants/app_colors.dart';

class Kfonts {
  // static const family = "Montserrat";
  static const family = "Inter_18";

  static const TextStyle semiBold48 = TextStyle(
    fontSize: 48,
    color: Kcolor.gray,
    fontFamily: Kfonts.family,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle semiBold20 = TextStyle(
    fontSize: 20,
    color: Kcolor.gray,
    fontFamily: Kfonts.family,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle semiBold14 = TextStyle(
    fontSize: 14,
    color: Kcolor.gray,
    fontFamily: Kfonts.family,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle meduim16 = TextStyle(
    fontSize: 16,
    color: Kcolor.titleColor,
    fontFamily: Kfonts.family,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle meduim20 = TextStyle(
    fontSize: 20,
    color: Kcolor.titleColor,
    fontFamily: Kfonts.family,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle regular16 = TextStyle(
    fontSize: 16,
    color: Kcolor.subtitleText,
    fontFamily: Kfonts.family,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle regular14 = TextStyle(
    fontSize: 14,
    color: Kcolor.subtitleText,
    fontFamily: Kfonts.family,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle regular18Black = TextStyle(
    fontSize: 18,
    color: Kcolor.black,
    fontFamily: Kfonts.family,
    fontWeight: FontWeight.w400,
  );
}
