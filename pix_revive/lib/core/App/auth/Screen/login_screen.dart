import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pix_revive/core/App/auth/data/cubit/Auth_cubit.dart';
import 'package:pix_revive/core/App/auth/data/cubit/cubit_state.dart';
import 'package:pix_revive/core/App/auth/data/model/auth_model.dart';
import 'package:pix_revive/core/Functions/custom_flushbar.dart';
import 'package:pix_revive/core/Functions/loading_dialog.dart';
import 'package:pix_revive/core/constants/app_colors.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/constants/app_icons.dart';
import 'package:pix_revive/core/router/go_router.dart';
import 'package:pix_revive/core/api/dio_client.dart';

import 'package:pix_revive/core/widgets/inputs/text_form_field_email.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is LoadingState) {
          loadingDialog(context); // size why didint change
        }
        if (state is ErrorState) {
          pop(context);
          customFlushbar(state.message).show(context);
        }
        if (state is SuccsessState) {
          go(
            context,
            KRoutes.navbar,
            extra: cubit.responseLoginRegister!.user!.username,
          );
        }
      },
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(),
            Text(
              "Email",
              style: Kfonts.meduim16.copyWith(
                fontSize: 14,
                color: Kcolor.black,
              ),
            ),
            const Gap(8),
            CustomTextFormFieldEmail(
              hint: "you@example.com",
              controller: cubit.email,
              prefixIcon: CustomIconTextFormField(icon: Kicon.email),
              validator: (value) {
                if (!RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                ).hasMatch(value!)) {
                  return "Invalid email";
                }
                return null;
              },
            ),
            const Gap(20),
            Text(
              "Password",
              style: Kfonts.meduim16.copyWith(
                fontSize: 14,
                color: Kcolor.black,
              ),
            ),
            const Gap(8),
            CustomTextFormFieldPassword(
              controller: cubit.password,
              hint: "••••••••",
              prefixIcon: CustomIconTextFormField(icon: Kicon.lock),
              suffixIcon: CustomIconTextFormField(icon: Kicon.closeEye),
              validator: (value) {
                if (value == null || value.length < 6) {
                  return "Password must be at least 8 characters";
                }
                return null;
              },
            ),
            const Gap(4),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  push(context, KRoutes.forgotPassword);
                },
                child: Text(
                  "Forgot password?",
                  style: Kfonts.meduim16.copyWith(
                    fontSize: 13,
                    color: Kcolor.mainColor,
                  ),
                ),
              ),
            ),

            const Gap(13),
            CustomMainButton(
              text: "Sign in",
              onTap: () {
                Future.delayed(Duration(milliseconds: 150), () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.loginAndRegiter(
                      Endpoints.login,
                      AuthModel(
                        email: cubit.email.text,
                        password: cubit.password.text,
                      ),
                    );
                  }
                });
              },
            ),

            const Gap(13),
            GoogleButton(
              onTap: () async{
                Future.delayed(
                  Duration(milliseconds: 150),
                  () async=> await cubit.loginWithGoogle(),
                );
              },
              child: Center(
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Kicon.google, width: 24),

                    const Text("continue with Google", style: Kfonts.meduim16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, this.child, this.onTap});
  final Widget? child;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashFactory: InkSplash.splashFactory,

      onTap: onTap,
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Kcolor.white,
          border: Border.all(color: Kcolor.inputTextFormField),
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }
}

class CustomMainButton extends StatelessWidget {
  const CustomMainButton({super.key, required this.text, this.onTap});
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashFactory: InkSplash.splashFactory,
      onTap: onTap,
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Kcolor.mainColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 24,
              color: Kcolor.mainColor.withValues(alpha: 0.2),
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: Kfonts.meduim16.copyWith(color: Kcolor.white),
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
