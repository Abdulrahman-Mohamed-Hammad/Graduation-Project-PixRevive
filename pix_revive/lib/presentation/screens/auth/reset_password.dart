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

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusNodeOff(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(),
                    CustomLogo(icon: Kicon.shield),
                    const Gap(16),
                    const Text("Reset Password", style: Kfonts.meduim16),
                    const Gap(8),
                    const Text(
                      "Enter the Otp sent to your email and create a new passsword",
                      style: Kfonts.regular16,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Verification Code",
                        style: Kfonts.meduim16.copyWith(
                          fontSize: 14,
                          color: Kcolor.black,
                        ),
                      ),
                    ),
                    const Gap(8),
                    // SizedBox(width: 400,child: Pinput(controller: TextEditingController(),length: 6,defaultPinTheme: PinTheme(width: 60,height: 60,padding: EdgeInsets.all(10),decoration: BoxDecoration(border: Border.all(color: Kcolor.inputTextFormField),color: Kcolor.white,borderRadius: BorderRadius.circular(12))),)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "New Password",
                        style: Kfonts.meduim16.copyWith(
                          fontSize: 14,
                          color: Kcolor.black,
                        ),
                      ),
                    ),
                    const Gap(8),
                    CustomTextFormFieldPassword(
                      hint: "••••••••",
                      prefixIcon: CustomIconTextFormField(icon: Kicon.lock),
                      suffixIcon: CustomIconTextFormField(icon: Kicon.openeye),
                    ),
                    const Gap(20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Confirm Password",
                        style: Kfonts.meduim16.copyWith(
                          fontSize: 14,
                          color: Kcolor.black,
                        ),
                      ),
                    ),
                    const Gap(8),
                    CustomTextFormFieldPassword(
                      hint: "••••••••",
                      prefixIcon: CustomIconTextFormField(icon: Kicon.lock),
                      suffixIcon: CustomIconTextFormField(icon: Kicon.openeye),
                    ),
                    const Gap(20),
                    CustomMainButton(text: "Reset Password"),
                    const Gap(15),
                    InkWell(
                      onTap: () {
                        go(context, KRoutes.authControllerScreen);
                      },
                      child: Text(
                        "Back to Login",
                        style: Kfonts.meduim16.copyWith(
                          color: Kcolor.endGradient,
                          fontSize: 14,
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
