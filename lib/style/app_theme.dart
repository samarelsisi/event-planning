import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        shape: StadiumBorder(
            side: BorderSide(color: AppColors.whiteColor, width: 4))),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.blackColor),
        backgroundColor: AppColors.whiteColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        selectedLabelStyle: AppStyles.bold12White,
        unselectedLabelStyle: AppStyles.bold12White,
        elevation: 0),
    scaffoldBackgroundColor: AppColors.whiteColor,
  );
  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryDark,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryDark,
          shape: StadiumBorder(
              side: BorderSide(color: AppColors.whiteColor, width: 4))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: true,
          selectedLabelStyle: AppStyles.bold12White,
          unselectedLabelStyle: AppStyles.bold12White,
          elevation: 0),
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.primaryLight),
          backgroundColor: AppColors.primaryDark),
      scaffoldBackgroundColor: AppColors.primaryDark,
      textTheme: TextTheme(
          bodyLarge: AppStyles.bold24White,
          bodyMedium: AppStyles.medium14White));
}
