import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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
                  push(context, KRoutes.resetPassword, extra: cubit.email.text);
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
                        controller: cubit.email,
                        prefixIcon: CustomIconTextFormField(icon: Kicon.email),
                      ),
                      const Gap(20),
                      CustomMainButton(
                        text: "Reset Password",
                        onTap: () =>
                            Future.delayed(Duration(milliseconds: 150), () {
                              cubit.requestResetPassword(
                                Endpoints.requestResetPassword,
                                AuthModel(email: cubit.email.text),
                              );
                            }),
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
                              color: Kcolor.mainColor,
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
      ),
    );
  }
}
