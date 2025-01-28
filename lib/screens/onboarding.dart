import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/providers/app_theme_provider.dart';
import 'package:event_palnning_project/screens/homescreen.dart';
import 'package:event_palnning_project/style/app_styles.dart';
import 'package:event_palnning_project/style/assets_manager.dart';
import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../style/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = "onboarding screen";

  const OnboardingScreen({super.key});

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(
      'assets/images/$assetName',
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    String languageCode = context.locale.languageCode;

    // Define the icon based on the language
    IconData icon = languageCode == 'ar'
        ? Icons.arrow_circle_left_outlined // For Arabic
        : Icons.arrow_circle_right_outlined; // For English and other languages
    IconData iconl = languageCode == 'ar'
        ? Icons.arrow_circle_right_outlined // For Arabic
        : Icons.arrow_circle_left_outlined;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var pageDecoration = PageDecoration(
      titleTextStyle: AppStyles.bold20Primary,
      bodyTextStyle: themeProvider.appTheme == ThemeMode.light
          ? AppStyles.medium16Black.copyWith()
          : AppStyles.medium16White,
      pageColor: themeProvider.appTheme == ThemeMode.light
          ? AppColors.whiteColor
          : AppColors.primaryDark,
      imageFlex: 4,
      imagePadding: EdgeInsets.only(top: 30),
      titlePadding: EdgeInsets.only(
        left: 16.0,
      ),
      // Align title to the left
      bodyAlignment: Alignment.topLeft,
      // Align body text to the left
    );
    return IntroductionScreen(
      globalHeader: Image.asset(
        AssetsManager.bar_logo,
        height: 171,
      ),
      dotsFlex: 2,
      dotsDecorator: const DotsDecorator(
        color: Color(0xFF707070),
        activeColor: AppColors.primaryLight,
      ),
      globalBackgroundColor: themeProvider.appTheme == ThemeMode.light
          ? AppColors.whiteColor
          : AppColors.primaryDark,
      showDoneButton: true,
      done: Text(
        "Done",
        style: AppStyles.medium16Primary,
      ),
      onDone: () {
        Navigator.pushNamed(context, Homescreen.routeName);
      },
      showNextButton: true,
      next: Icon(icon, color: AppColors.primaryLight, size: 40),
      showBackButton: true,
      back: Icon(iconl, color: AppColors.primaryLight, size: 40),
      pages: [
        PageViewModel(
          title: "onboarding_t1".tr(),
          body: "onboarding_d2".tr(),
          image: _buildImage(themeProvider.appTheme != ThemeMode.light
              ? 'onboarding_d1.png'
              : 'onboarding1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "onboarding_t2".tr(),
          body: "onboarding_d2".tr(),
          image: _buildImage(themeProvider.appTheme != ThemeMode.light
              ? 'onboarding_d2.png'
              : 'onboarding2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "onboarding_t3".tr(),
          body: "onboarding_d3".tr(),
          image: _buildImage(themeProvider.appTheme != ThemeMode.light
              ? 'onboarding_d3.png'
              : 'onboarding3.png'),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
