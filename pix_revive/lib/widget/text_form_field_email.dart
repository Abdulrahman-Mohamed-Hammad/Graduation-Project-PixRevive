import 'package:flutter/material.dart';
import 'package:pix_revive/Utils/constant_color.dart';
import 'package:pix_revive/Utils/constant_font.dart';

class CustomTextFormFieldEmail extends StatelessWidget {
  const CustomTextFormFieldEmail({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.controller,

    this.error,
  });
  final String hint;
  final String? error;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // style: Kfont.meduim16.copyWith(color: Kcolors.black),
      inputFormatters: [
        // FilteringTextInputFormatter.deny(KreglurExpression.denySpace),
      ],
      decoration: inputDecoration.copyWith(
        prefixIcon: prefixIcon,
        hintText: hint,hintStyle: Kfont.regular16.copyWith(fontSize: 14,color: Kcolor.inputTextFormField)
      ),
      cursorColor: Kcolor.black,
      cursorErrorColor: Kcolor.black,
      textInputAction: TextInputAction.next,
    );
  }
}

class CustomTextFormFieldPassword extends StatelessWidget {
  const CustomTextFormFieldPassword({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.controller,

    this.error,
    this.suffixIcon,
  });
  final String hint;
  final String? error;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // style: Kfont.meduim16.copyWith(color: Kcolors.black),
      inputFormatters: [
        // FilteringTextInputFormatter.deny(KreglurExpression.denySpace),
      ],
      decoration: inputDecoration.copyWith(
        prefixIcon: prefixIcon,
        hintText: hint,
        suffixIcon: suffixIcon
      ),
      cursorColor: Kcolor.black,
      cursorErrorColor: Kcolor.black,
      textInputAction: TextInputAction.next,
    );
  }
}
