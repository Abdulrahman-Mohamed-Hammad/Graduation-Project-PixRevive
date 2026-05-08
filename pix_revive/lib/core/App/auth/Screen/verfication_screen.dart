import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pix_revive/core/App/auth/Screen/reset_password.dart';
import 'package:pix_revive/core/App/auth/data/cubit/Auth_cubit.dart';
import 'package:pix_revive/core/App/auth/data/cubit/cubit_state.dart';
import 'package:pix_revive/core/App/auth/data/model/auth_model.dart';
import 'package:pix_revive/core/Functions/custom_flushbar.dart';
import 'package:pix_revive/core/Functions/loading_dialog.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/constants/app_icons.dart';
import 'package:pix_revive/core/router/go_router.dart';

import 'package:pix_revive/core/App/auth/Screen/auth_controller.dart';
import 'package:pix_revive/core/App/auth/Screen/login_screen.dart';

import 'package:pix_revive/core/widgets/misc/focus_node_off.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return FocusNodeOff(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: BlocListener<AuthCubit, AuthCubitState>(
              listener: (context, state) {
                if (state is LoadingState) {
                  loadingDialog(context);
                }
                if (state is ErrorState) {
                  pop(context);
                  customFlushbar(state.message).show(context);
                }
                if (state is SuccsessState) {
                  pop(context);
                  go(context, KRoutes.home);
                }
              },
              child: SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomLogo(icon: Kicon.email),
                      const Gap(16),
                      Text("Check your email", style: Kfonts.meduim16),
                      const Gap(8),
                      Text(
                        "We sent a verification code to your Email",
                        style: Kfonts.regular16,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                      ),
                      const Gap(30),
                      CustomOtp(controller: cubit.otp),
                      const Gap(20),
                      CustomMainButton(
                        text: "Verify Email",
                        onTap: () =>
                            Future.delayed(Duration(milliseconds: 150), () {
                              cubit.verifyEmail(
                                AuthResetpasswordModel(
                                  email: email,
                                  otp: cubit.otp.text,
                                ),
                              );
                            }),
                      ),
                      const Gap(15),
                      //  ResendOtp(text1: "Didn't receive code?", text2: "Resend",onTap: () => cubit.requestResetPassword(Endpoints.requestResetPassword, AuthModel(email: email),false),),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
