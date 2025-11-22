import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pix_revive/core/constants/app_colors.dart';

import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/constants/app_icons.dart';
import 'package:pix_revive/core/router/go_router.dart';
import 'package:pix_revive/data/services/api/dio_client.dart';
import 'package:pix_revive/presentation/providers/auth_provider.dart';
import 'package:pix_revive/presentation/screens/auth/login_screen.dart';
import 'package:pix_revive/presentation/widgets/inputs/text_form_field_email.dart';

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
          debugPrint("error");
        }
        if (state is SuccsessState) {
          pop(context);
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
            suffixIcon: CustomIconTextFormField(icon: Kicon.openeye),
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
