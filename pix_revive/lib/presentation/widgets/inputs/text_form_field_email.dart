import 'package:flutter/material.dart';

import 'package:pix_revive/core/constants/app_colors.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';

class CustomTextFormFieldEmail extends StatelessWidget {
  const CustomTextFormFieldEmail({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.controller,

    this.error,
    this.validator,
  });
  final String hint;
  final String? error;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

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
        hintStyle: Kfonts.regular16.copyWith(
          fontSize: 14,
          color: Kcolor.inputTextFormField,
        ),
      ),
      cursorColor: Kcolor.black,
      cursorErrorColor: Kcolor.black,
      textInputAction: TextInputAction.next,
      validator: validator,
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
    this.validator,
  });
  final String hint;
  final String? error;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
   final FormFieldValidator<String>? validator;

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
        suffixIcon: suffixIcon,
      ),
      cursorColor: Kcolor.black,
      cursorErrorColor: Kcolor.black,
      textInputAction: TextInputAction.next,
      validator: validator,
    );
  }
}
