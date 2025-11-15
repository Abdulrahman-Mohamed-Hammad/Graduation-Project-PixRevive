

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pix_revive/Utils/constant_color.dart';
import 'package:pix_revive/Utils/constant_font.dart';
import 'package:pix_revive/Utils/constant_icon.dart';
import 'package:pix_revive/feature/Auth/Screens/Login/login_s.dart';
import 'package:pix_revive/feature/Auth/Screens/controller/auth_controller_screen.dart';
import 'package:pix_revive/routes/go_router.dart';
import 'package:pix_revive/widget/focus_node_off.dart';
import 'package:pix_revive/widget/text_form_field_email.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusNodeOff(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(width: 400,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [ CustomLogo(icon: Kicon.email,),
                          const Gap(16),
                          Text("Forgot Password?", style: Kfont.meduim16),
                          const Gap(8),
                          Text("Enter your email to receive code", style: Kfont.regular16,overflow: TextOverflow.ellipsis,),
                          const Gap(30),
                                  CustomTextFormFieldEmail(
                hint: "you@example.com",
                controller: TextEditingController(),
                prefixIcon: CustomIconTextFormField(icon: Kicon.email),
              ),
              const Gap(20),
               CustomMainButton(text: "Reset Password"),
               const Gap(15),
               Center(child: InkWell(onTap: () {
                 pop(context);
               },child: Text("Back to Login",style: Kfont.meduim16.copyWith(color: Kcolor.endGradient,fontSize: 14),)))
              
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