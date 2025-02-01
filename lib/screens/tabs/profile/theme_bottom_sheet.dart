import 'package:easy_localization/easy_localization.dart';
import '../../../../providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../style/app_colors.dart';
import '../../../style/app_styles.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          themeOption(
            context,
            title: "light".tr(),
            mode: ThemeMode.light,
            isSelected: themeProvider.appTheme == ThemeMode.light,
          ),
          SizedBox(height: height * 0.02),
          themeOption(
            context,
            title: "dark".tr(),
            mode: ThemeMode.dark,
            isSelected: themeProvider.appTheme == ThemeMode.dark,
          ),
        ],
      ),
    );
  }

  Widget themeOption(BuildContext context,
      {required String title,
      required ThemeMode mode,
      required bool isSelected}) {
    var themeProvider = Provider.of<AppThemeProvider>(context, listen: false);

    return InkWell(
      onTap: () => themeProvider.changeProfileThemes(mode),
      child: isSelected
          ? getSelectedItemWidget(title)
          : getUnSelectedItemWidget(title),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppStyles.bold20Primary),
        const Icon(Icons.check, size: 25, color: AppColors.primaryLight),
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Text(text, style: AppStyles.bold20Black);
  }
}
