import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_revive/core/App/data/cubit/app_cubit.dart';
import 'package:pix_revive/core/App/data/cubit/cubit_state.dart';
import 'package:pix_revive/core/App/screen/history-page.dart';
import 'package:pix_revive/core/App/screen/home_screen.dart';
import 'package:pix_revive/core/constants/app_colors.dart';

import 'package:pix_revive/core/router/go_router.dart';

class NavbarApp extends StatefulWidget {
  const NavbarApp({super.key, required this.name});
  final String name;
  @override
  State<NavbarApp> createState() => _NavbarAppState();
}

class _NavbarAppState extends State<NavbarApp> {
  List<Widget>? pages;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppCubitState>(
      listener: (context, state) {
        if (state is FailedToAccessNewToken) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            go(context, KRoutes.authControllerScreen);
          });
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Kcolor.white,
        bottomNavigationBar: CustomContainer(
          height: 60,
          color: Kcolor.white,
          padding: 16,
          corner: 24,
          margin: EdgeInsets.fromLTRB(24, 0, 24, 20),
          boxShadow: [
            BoxShadow(
              color: Kcolor.black.withValues(alpha: 0.09),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClickableText(
                text: "Home",
                index: 0,
                onTap: (value) {
                  if (value != index) {
                    setState(() {
                      index = value;
                    });
                  }
                },
                color: index == 0 ? Kcolor.mainColor : Kcolor.gray,
              ),
              ClickableText(
                text: "History",
                index: 1,
                onTap: (value) {
                  if (value != index) {
                    setState(() {
                      index = value;
                    });
                  }
                },
                color: index == 1 ? Kcolor.mainColor : Kcolor.gray,
              ),
            ],
          ),
        ),
        body: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 70, 24, 0),
            child: IndexedStack(
              index: index,
              children: [
                Home(name: widget.name),
                History(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
