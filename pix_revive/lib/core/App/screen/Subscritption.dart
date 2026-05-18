import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pix_revive/core/App/auth/Screen/login_screen.dart';
import 'package:pix_revive/core/App/data/cubit/app_cubit.dart';
import 'package:pix_revive/core/App/data/cubit/cubit_state.dart';
import 'package:pix_revive/core/App/screen/home_screen.dart';
import 'package:pix_revive/core/api/dio_client.dart';
import 'package:pix_revive/core/constants/app_colors.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/constants/app_icons.dart';
import 'package:pix_revive/core/router/go_router.dart';

class SubscritptionPlan extends StatelessWidget {
  const SubscritptionPlan({super.key});
 
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AppCubit>();
    final isActive = 0;
    return Scaffold(
      body: BlocBuilder<AppCubit,AppCubitState>(
        builder: (BuildContext context, AppCubitState state) =>
         SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(children: [
                  GestureDetector(
                          onTap: () => pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Kcolor.white,
                              border: Border.all(color: Kcolor.gray.withValues(alpha: 0.3)),
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: SvgPicture.asset(Kicon.backArrow, width: 20),
                          ),
                        ),
                  const Gap(16),
                  Text("Subscription Plan", style: Kfonts.semiBold20),
                ],),
              
                const Gap(24),
                Expanded(
                  child: CustomContainer(
                    width: double.infinity,
                    corner: 24,
                    padding: 16,
                    border: Border.all(color: isActive ==0 ? Kcolor.mainColor :  Kcolor.gray.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Kcolor.black.withValues(alpha: 0.09),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: Kcolor.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Free Plan", style: Kfonts.semiBold20),
                        Text(
                          "\$0",
                          style: Kfonts.semiBold48.copyWith(fontSize: 40),
                        ),
                        Text("forever"),
                        const Gap(10),
                        Divider(color: Kcolor.gray.withValues(alpha: 0.3)),
                        const Gap(10),
                        Text("2 image enhancement per day",style: Kfonts.meduim16,),
                        const Gap(5),
                        Text("Access to all features",style: Kfonts.meduim16,),
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async{
                          log("message");
                       var key =   await cubit.payment();
                       if(key != null){
                        push (context, KRoutes.paymentWebView, extra:["https://accept.paymob.com/api/acceptance/iframes/1041513?payment_token=$key", cubit.orderID ?? ""]);
                       }
                        },
                      child: CustomContainer(
                      width: double.infinity,
                      corner: 24,
                      padding: 16,
                      border: Border.all(color: Kcolor.gray.withValues(alpha: 0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Kcolor.black.withValues(alpha: 0.09),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Kcolor.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PRO", style: Kfonts.semiBold20),
                          Text(
                            "\$4.99",
                            style: Kfonts.semiBold48.copyWith(fontSize: 40),
                          ),
                          Text("per month"),
                          const Gap(10),
                          Divider(color: Kcolor.gray.withValues(alpha: 0.3)),
                          const Gap(10),
                          Text("unlimited image enhancement",style: Kfonts.meduim16),
                          const Gap(5),
                          Text("Access to all features",style: Kfonts.meduim16,),
                          const Gap(30),
                          if(state is LoadingState) Align(child: SizedBox(width: 50,child: Lottie.asset(Kicon.aiLoading)))
                        ],
                      ),
                                    ),
                    ),
                  ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
