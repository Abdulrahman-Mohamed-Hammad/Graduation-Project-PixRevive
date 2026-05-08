import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:pix_revive/core/App/auth/data/cubit/Auth_cubit.dart';
import 'package:pix_revive/core/App/auth/data/cubit/cubit_state.dart';
import 'package:pix_revive/core/App/auth/data/model/auth_model.dart';
import 'package:pix_revive/core/Functions/custom_flushbar.dart';
import 'package:pix_revive/core/Functions/loading_dialog.dart';

import 'package:pix_revive/core/api/dio_client.dart';
import 'package:pix_revive/core/constants/app_colors.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/constants/app_icons.dart';
import 'package:pix_revive/core/router/go_router.dart';
import 'package:pix_revive/core/App/auth/Screen/auth_controller.dart';
import 'package:pix_revive/core/App/auth/Screen/login_screen.dart';
import 'package:pix_revive/core/widgets/inputs/text_form_field_email.dart';
import 'package:pix_revive/core/widgets/misc/focus_node_off.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return FocusNodeOff(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: EdgeInsets.all(24),
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
                      push(context, KRoutes.authControllerScreen);
                    }
                  },
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
                      CustomOtp(
                        focusNode: cubit.focusNode,
                        controller: cubit.otp,
                      ),
                      const Gap(16),
                      ResendOtp(
                        text1: "Didn't receive code?",
                        text2: "Resend",
                        onTap: () => cubit.requestResetPassword(
                          Endpoints.requestResetPassword,
                          AuthModel(email: email),
                          false,
                        ),
                      ),
                      const Gap(8),
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
                        controller: cubit.password,
                        focusNode: cubit.focusNode,
                        hint: "••••••••",
                        prefixIcon: CustomIconTextFormField(icon: Kicon.lock),
                        suffixIcon: CustomIconTextFormField(
                          icon: Kicon.closeEye,
                        ),
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
                        controller: cubit.confirmpassword,
                        hint: "••••••••",
                        prefixIcon: CustomIconTextFormField(icon: Kicon.lock),
                      ),
                      const Gap(20),
                      CustomMainButton(
                        text: "Reset Password",
                        onTap: () =>
                            Future.delayed(Duration(milliseconds: 150), () {
                              cubit.requestResetPassword(
                                Endpoints.resetPassword,
                                AuthResetpasswordModel(
                                  email: email,
                                  otp: cubit.otp.text,
                                  newPassword: cubit.password.text,
                                ),
                              );
                            }),
                      ),
                      const Gap(15),
                      InkWell(
                        onTap: () {
                          go(context, KRoutes.authControllerScreen);
                        },
                        child: Text(
                          "Back to Login",
                          style: Kfonts.meduim16.copyWith(
                            color: Kcolor.mainColor,
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
      ),
    );
  }
}

class ResendOtp extends StatefulWidget {
  const ResendOtp({
    super.key,
    required this.text1,
    required this.text2,
    this.onTap,
  });
  final String text1;
  final String text2;
  final VoidCallback? onTap;

  @override
  State<ResendOtp> createState() => _ResendOtpState();
}

class _ResendOtpState extends State<ResendOtp> {
  late String text1;
  late String text2;
  Timer? t;
  bool isClicked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text1 = widget.text1;
    text2 = widget.text2;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text1, style: Kfonts.regular14.copyWith(color: Kcolor.black)),
        InkWell(
          onTap: isClicked == false
              ? () {
                  widget.onTap!();
                  timer();
                }
              : null,
          child: Text(
            text2,
            style: Kfonts.meduim16.copyWith(
              color: Kcolor.mainColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    t?.cancel();
  }

  void timer() {
    setState(() {
      isClicked = true;
    });
    int timerCount = 60;
    t = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        text2 = (--timerCount).toString();
      });
      if (timer == 0) {
        setState(() {
          text2 = widget.text2;
          isClicked = false;
          t.cancel();
        });
      }
    });
  }
}

class CustomOtp extends StatelessWidget {
  const CustomOtp({super.key, this.focusNode, this.controller});

  final FocusNode? focusNode;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 55,
      child: Pinput(
        length: 6,
        autofocus: false,
        controller: controller,
        textInputAction: TextInputAction.next,
        separatorBuilder: (index) => Gap(5),
        onSubmitted: (value) => focusNode!.requestFocus(),
        cursor: Container(
          height: 20,
          width: 2,
          color: Kcolor.inputTextFormField,
        ),
        animationDuration: Duration.zero,
        animationCurve: Curves.linear,
        defaultPinTheme: PinTheme(
          height: 55,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(color: Kcolor.bordorTextFormField),
            color: Kcolor.lightgray,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
