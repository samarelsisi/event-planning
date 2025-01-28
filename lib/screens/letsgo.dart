import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/providers/app_theme_provider.dart';
import 'package:event_palnning_project/screens/onboarding.dart';
import 'package:event_palnning_project/style/app_colors.dart';
import 'package:event_palnning_project/style/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
class LetsGo extends StatefulWidget {
  static const String routeName = "let's go screen";

  const LetsGo({super.key});

  @override
  State<LetsGo> createState() => _LetsGoState();
}

class _LetsGoState extends State<LetsGo> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManager.bar_logo),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Image.asset(
              AssetsManager.being_creative,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 28,
          ),
          Text(
            context.tr("title_letsgo"),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.primaryLight),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            context.tr("des_letsgo"),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "language".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.primaryLight),
              ),
              ToggleSwitch(
                minWidth: 73.0,
                minHeight: 30.0,
                initialLabelIndex: 0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                icons: [
                  context.locale.toString() == "en"
                      ? FontAwesomeIcons.flagUsa
                      : MdiIcons.abjadArabic,
                  context.locale.toString() != "en"
                      ? FontAwesomeIcons.flagUsa
                      : MdiIcons.abjadArabic,
                ],
                iconSize: 30.0,
                activeBgColors: [
                  context.locale.toString() == "en"
                      ? [
                          Theme.of(context).primaryColor,
                          Theme.of(context).hintColor
                        ]
                      : [AppColors.primaryLight, AppColors.whiteColor],
                  context.locale.toString() == "en"
                      ? [
                          Theme.of(context).primaryColor,
                          Theme.of(context).hintColor
                        ]
                      : [AppColors.primaryLight, AppColors.whiteColor],
                ],
                animate: true,
                curve: Curves.bounceInOut,
                onToggle: (index) {
                  if (context.locale.toString() == "en") {
                    if (index == 0) {
                      context.setLocale(Locale('en'));
                    } else {
                      context.setLocale(Locale('ar'));
                    }
                  } else {
                    if (index == 1) {
                      context.setLocale(Locale('en'));
                    } else {
                      context.setLocale(Locale('ar'));
                    }
                  }
                },
              ),
            ], // en >> 0 , ar >> 1
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "theme".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.primaryLight),
              ),
              ToggleSwitch(
                minWidth: 73.0,
                minHeight: 30.0,
                initialLabelIndex: 0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                icons: [
                  themeProvider.appTheme == ThemeMode.light
                      ? MdiIcons.lightbulb
                      : FontAwesomeIcons.moon,
                  themeProvider.appTheme != ThemeMode.light
                      ? MdiIcons.lightbulb
                      : FontAwesomeIcons.moon,
                ],
                iconSize: 30.0,
                activeBgColors: [
                  themeProvider.appTheme == ThemeMode.light
                      ? [AppColors.primaryLight, AppColors.whiteColor]
                      : [
                          Theme.of(context).primaryColor,
                          Theme.of(context).hintColor
                        ],
                  themeProvider.isDarkMode()
                      ? [AppColors.primaryLight, AppColors.whiteColor]
                      : [
                          Theme.of(context).primaryColor,
                          Theme.of(context).hintColor
                        ],
                ],
                animate: true,
                curve: Curves.bounceInOut,
                onToggle: (index) {
                  themeProvider.changeTheme();
                },
              ),
            ],
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 18.0,
          right: 18,
          left: 18,
        ),
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, OnboardingScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: Color(0xFF5669FF)),
            child: Text(
              "lets_start".tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            )),
      ),
    );
  }
}
