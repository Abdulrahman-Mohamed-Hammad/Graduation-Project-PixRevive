import 'dart:ui';

import 'package:flutter/material.dart';

class Kcolor {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const gray = Color(0xFF414348);
  static const lightgray = Color(0xFFF3F4F6);

  static const firstGradient = Color(0xFF23BFC5);
  static const endGradient = Color(0xFF1a9399);
  static const mainColor = Color(0xFF23BFC5);

  static const titleColor = Color(0xFF1a1a1a);
  static const label = Color(0xFF374151);
  static const subtitleText = Color(0xFF4B5563);
  static const inputTextFormField = Color(0xFF9CA3AF);
  static const bordorTextFormField = Color(0xFFE5E7EB);
}

OutlineInputBorder custombordor = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(color: Color(0xFFE5E7EB)),
);

var inputDecoration = InputDecoration(
  enabledBorder: custombordor,
  focusedBorder: custombordor,
  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
  isDense: true,

  hintStyle: TextStyle(color: Kcolor.inputTextFormField),
  filled: true,
  errorBorder: custombordor,
  focusedErrorBorder: custombordor,

  floatingLabelAlignment: FloatingLabelAlignment.start,
  fillColor: Kcolor.lightgray.withValues(alpha: 0.3),
);
