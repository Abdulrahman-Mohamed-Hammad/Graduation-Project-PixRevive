import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pix_revive/core/constants/app_colors.dart';

Flushbar<dynamic> customFlushbar(String text, [Color color = Kcolor.red]) =>
    Flushbar(
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color,
      message: text,
      duration: Duration(seconds: 2),
    );
