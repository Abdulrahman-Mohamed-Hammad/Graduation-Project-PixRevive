import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pix_revive/Utils/constant_color.dart';
import 'package:pix_revive/Utils/constant_font.dart';
import 'package:pix_revive/Utils/constant_icon.dart';
import 'package:pix_revive/feature/Auth/Screens/Login/login_s.dart';
import 'package:pix_revive/feature/Auth/Screens/Register/signup_screen.dart';
import 'package:pix_revive/widget/focus_node_off.dart';

class AuthControllerScreen extends StatefulWidget {
  const AuthControllerScreen({super.key});

  @override
  State<AuthControllerScreen> createState() => _AuthControllerScreenState();
}

class _AuthControllerScreenState extends State<AuthControllerScreen> {
  List<String> text = ["Welcome Back", "Sign in to continue your journey","Create Account","Join us and start your journey today"];
  String text1 ="Welcome Back";
  String text2 ="Sign in to continue your journey";
  Switch switcher = Switch.login;
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
                    CustomLogo(icon: Kicon.lock,),
                    const Gap(16),
                    Text(text1, style: Kfont.meduim16),
                    const Gap(8),
                    Text(text2, style: Kfont.regular16),
                    const Gap(30),
                    BackContiner(
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: "Login",
                              switcher: Switch.login,
                              onTap: switcher == Switch.signUp
                                  ? () {
                                      setState(() {
                                        switcher = Switch.login;
                                         text1 =text[0];
                                         text2 =text[1];
                                      });
                                    }
                                  : null,
                            ),
                          ),
                          Expanded(
                            child: CustomButton(
                              text: "Sign Up",switcher: Switch.signUp,
                              onTap: switcher == Switch.login
                                  ? () {
                                      setState(() {
                                        switcher = Switch.signUp;
                                         text1 =text[2];
                                         text2 =text[3];
                                      });
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    switcher == Switch.login
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: LoginScreen(),
                          )
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: SignupScreen(),
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

enum Switch { login, signUp }

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onTap, required this.switcher});
  final String text;
  final VoidCallback? onTap;
  final Switch switcher;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: onTap == null ? Kcolor.white : Colors.transparent,
          borderRadius:switcher == Switch.signUp?BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12)):BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12)),
          boxShadow: [
            if (onTap == null)
              BoxShadow(
                color: Color(0xFF1a1a1a).withValues(alpha: 0.1),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: Kfont.semiBold48.copyWith(fontSize: 14, color:onTap ==null?  Kcolor.endGradient:Kcolor.black),
          ),
        ),
      ),
    );
  }
}

class BackContiner extends StatelessWidget {
  const BackContiner({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Kcolor.lightgray.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key, required this.icon});
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Kcolor.firstGradient, Kcolor.endGradient],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: Kcolor.mainColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            color: Kcolor.firstGradient.withValues(alpha: 0.3),
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: SvgPicture.asset(icon,colorFilter: ColorFilter.mode(Kcolor.white,BlendMode.srcIn),),
    );
  }
}
