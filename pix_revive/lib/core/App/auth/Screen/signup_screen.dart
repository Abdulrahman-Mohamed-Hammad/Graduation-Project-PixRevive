import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import 'package:pix_revive/core/App/auth/Screen/login_screen.dart';
import 'package:pix_revive/core/widgets/inputs/text_form_field_email.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthCubitState>(
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
          pushReplacement(
            context,
            KRoutes.verifyEmail,
            extra: cubit.email.text,
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(),
          Text(
            "Full Name",
            style: Kfonts.meduim16.copyWith(fontSize: 14, color: Kcolor.black),
          ),
          const Gap(8),
          CustomTextFormFieldEmail(
            hint: "Johan Doe",
            controller: cubit.userNameController,
            prefixIcon: CustomIconTextFormField(icon: Kicon.user),
          ),
          const Gap(10),
          Text(
            "Email",
            style: Kfonts.meduim16.copyWith(fontSize: 14, color: Kcolor.black),
          ),
          const Gap(8),
          CustomTextFormFieldEmail(
            hint: "you@example.com",
            controller: cubit.email,
            prefixIcon: CustomIconTextFormField(icon: Kicon.email),
          ),
          const Gap(10),
          Text(
            "Password",
            style: Kfonts.meduim16.copyWith(fontSize: 14, color: Kcolor.black),
          ),
          const Gap(8),
          CustomTextFormFieldPassword(
            controller: cubit.password,
            hint: "••••••••",
            prefixIcon: CustomIconTextFormField(icon: Kicon.lock),
            suffixIcon: CustomIconTextFormField(icon: Kicon.closeEye),
          ),

          const Gap(20),
          CustomMainButton(
            text: "Create Account",
            onTap: () => cubit.loginAndRegiter(
              Endpoints.register,
              AuthModel(
                userName: cubit.userNameController.text,
                email: cubit.email.text,
                password: cubit.password.text,
                confirmpassword: cubit.password.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
