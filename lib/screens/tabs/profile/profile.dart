import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/screens/tabs/profile/theme_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_styles.dart';
import '../../../style/assets_manager.dart';
import '../../auth/login/login_screen.dart';
import 'language_bottom_sheet.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        automaticallyImplyLeading: false,
        toolbarHeight: height * 0.20,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
        title: Row(
          children: [
            Image.asset(AssetsManager.routeImage),
            SizedBox(
              width: width * 0.04,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Safwat',
                  style: AppStyles.bold24White,
                ),
                SizedBox(
                  width: width * .5,
                  child: Text(
                    'johnsafwat.route@gmail.com',
                    style: AppStyles.medium16White,
                    maxLines: 2,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "language".tr(),
              style: AppStyles.bold20Black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.locale.toString() == "en"
                          ? "english".tr()
                          : "arabic".tr(),
                      style: AppStyles.bold20Primary,
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryLight,
                      size: 35,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "theme".tr(),
              style: AppStyles.bold20Black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.isDarkMode() ? "dark".tr() : "light".tr(),
                      style: AppStyles.bold20Primary,
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryLight,
                      size: 35,
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04, vertical: height * 0.02),
                    backgroundColor: AppColors.redColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                onPressed: () {
                  // eventListProvider.filterEventsList = [];
                  // eventListProvider.selectedIndex = 0 ;
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      "logout".tr(),
                      style: AppStyles.regular20White,
                    )
                  ],
                )),
            SizedBox(
              height: height * 0.02,
            )
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => const LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => const ThemeBottomSheet());
  }
}
