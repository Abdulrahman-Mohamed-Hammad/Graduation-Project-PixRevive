import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pix_revive/Utils/constant_color.dart';
import 'package:pix_revive/Utils/constant_font.dart';
import 'package:pix_revive/Utils/constant_icon.dart';
import 'package:pix_revive/routes/go_router.dart';
import 'package:pix_revive/widget/text_form_field_email.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(),
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
        const Gap(20),
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
        const Gap(4),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(onTap: () {
            push(context,KRoutes.forgotPassword);
          },
            child: Text(
              "Forgot password?",
              style: Kfont.meduim16.copyWith(
                fontSize: 13,
                color: Kcolor.endGradient,
              ),
            ),
          ),
        ),

        const Gap(13),
        CustomMainButton(text: "Sign in"),

        const Gap(13),
        GoogleButton(child: Center(
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Kicon.google, width: 24),
            const   Text("Contine with Google", style: Kfont.meduim16),
            ],
          ),
        ), ),
      ],
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, this.child, this.onTap});
final Widget? child;
final VoidCallbackAction? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Kcolor.white,
          border: Border.all(color: Kcolor.inputTextFormField),
          borderRadius: BorderRadius.circular(16),
        ),
        child:child
      ),
    );
  }
}

class CustomMainButton extends StatelessWidget {
  const CustomMainButton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Kcolor.firstGradient, Kcolor.endGradient],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 24,
              color: Kcolor.firstGradient.withValues(alpha: 0.2),
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: Kfont.meduim16.copyWith(color: Kcolor.white),
          ),
        ),
      ),
    );
  }
}

class CustomIconTextFormField extends StatelessWidget {
  const CustomIconTextFormField({super.key, required this.icon});
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: SvgPicture.asset(
            icon,
            width: 26,
            colorFilter: ColorFilter.mode(
              Kcolor.inputTextFormField,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
