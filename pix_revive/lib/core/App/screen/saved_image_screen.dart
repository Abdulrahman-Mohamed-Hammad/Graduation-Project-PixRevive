import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pix_revive/core/App/SharedPreferences/shared_preferences.dart';

import 'package:pix_revive/core/App/auth/Screen/login_screen.dart';

import 'package:pix_revive/core/constants/app_icons.dart';
import 'package:pix_revive/core/router/go_router.dart';

class SavedImageScreen extends StatelessWidget {
  const SavedImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(Kicon.success, repeat: false),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: CustomMainButton(
                text: "Back to Home",
                onTap: () {
                  go(
                    context,
                    KRoutes.navbar,
                    extra: SharedPreferencesHelper.getString(
                      KSharedPreferencesKeys.username,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
