import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pix_revive/core/constants/app_colors.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/constants/app_icons.dart';
import 'package:pix_revive/core/router/go_router.dart';

import 'package:pix_revive/presentation/providers/auth_controller.dart';
import 'package:pix_revive/presentation/screens/auth/login_screen.dart';
import 'package:pix_revive/presentation/widgets/inputs/text_form_field_email.dart';

import 'package:pix_revive/presentation/widgets/misc/focus_node_off.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusNodeOff(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomLogo(icon: Kicon.email),
                    const Gap(16),
                    Text("Forgot Password?", style: Kfonts.meduim16),
                    const Gap(8),
                    Text(
                      "Enter your email to receive code",
                      style: Kfonts.regular16,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(30),
                    CustomTextFormFieldEmail(
                      hint: "you@example.com",
                      controller: TextEditingController(),
                      prefixIcon: CustomIconTextFormField(icon: Kicon.email),
                    ),
                    const Gap(20),
                    CustomMainButton(
                      text: "Reset Password",
                      onTap: () => go(context, KRoutes.resetPassword),
                    ),
                    const Gap(15),
                    Center(
                      child: InkWell(
                        onTap: () {
                          pop(context);
                        },
                        child: Text(
                          "Back to Login",
                          style: Kfonts.meduim16.copyWith(
                            color: Kcolor.endGradient,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
