import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pix_revive/Utils/constant_color.dart';
import 'package:pix_revive/Utils/constant_font.dart';
import 'package:pix_revive/Utils/constant_icon.dart';
import 'package:pix_revive/feature/Auth/Screens/Login/login_s.dart';
import 'package:pix_revive/widget/text_form_field_email.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(),
        Text(
          "Full Name",
          style: Kfont.meduim16.copyWith(fontSize: 14, color: Kcolor.black),
        ),
        const Gap(8),
        CustomTextFormFieldEmail(
          hint: "Johan Doe",
          controller: TextEditingController(),
          prefixIcon: CustomIconTextFormField(icon: Kicon.user),
        ),
        const Gap(10),
        Text(
          "Email",
          style: Kfont.meduim16.copyWith(fontSize: 14, color: Kcolor.black),
        ),
        const Gap(8),
        CustomTextFormFieldEmail(
          hint: "you@example.com",
          controller: TextEditingController(),
          prefixIcon: CustomIconTextFormField(icon: Kicon.email),
        ),
        const Gap(10),
        Text(
          "Password",
          style: Kfont.meduim16.copyWith(fontSize: 14, color: Kcolor.black),
        ),
        const Gap(8),
        CustomTextFormFieldPassword(
          hint: "••••••••",
          prefixIcon: CustomIconTextFormField(icon: Kicon.lock),
          suffixIcon: CustomIconTextFormField(icon: Kicon.openeye),
        ),

        const Gap(20),
        CustomMainButton(text: "Create Account"),
      ],
    );
  }
}
