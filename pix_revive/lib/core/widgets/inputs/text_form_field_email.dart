import 'package:flutter/material.dart';
import 'package:pix_revive/core/App/auth/Screen/login_screen.dart';

import 'package:pix_revive/core/constants/app_colors.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/constants/app_icons.dart';

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
      focusNode: FocusNode(),
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

class CustomTextFormFieldPassword extends StatefulWidget {
  const CustomTextFormFieldPassword({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.controller,

    this.error,
    this.suffixIcon,
    this.validator,
    this.focusNode,
  });
  final String hint;
  final String? error;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  @override
  State<CustomTextFormFieldPassword> createState() =>
      _CustomTextFormFieldPasswordState();
}

class _CustomTextFormFieldPasswordState
    extends State<CustomTextFormFieldPassword> {
  bool obscureText = true;
  Widget? suffixIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suffixIcon = widget.suffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      // style: Kfont.meduim16.copyWith(color: Kcolors.black),
      inputFormatters: [
        // FilteringTextInputFormatter.deny(KreglurExpression.denySpace),
      ],
      decoration: inputDecoration.copyWith(
        prefixIcon: widget.prefixIcon,
        hintText: widget.hint,
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                    if (obscureText) {
                      suffixIcon = widget.suffixIcon;
                    } else {
                      suffixIcon = CustomIconTextFormField(icon: Kicon.openeye);
                    }
                  });
                },
                child: suffixIcon,
              )
            : widget.suffixIcon,
      ),

      obscureText: obscureText,
      cursorColor: Kcolor.black,
      cursorErrorColor: Kcolor.black,
      textInputAction: TextInputAction.next,
      validator: widget.validator,
    );
  }
}
