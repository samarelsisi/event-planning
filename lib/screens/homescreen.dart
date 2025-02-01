import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/screens/tabs/home/add_event/add_event.dart';
import 'package:event_palnning_project/screens/tabs/home/home_tab.dart';
import 'package:event_palnning_project/screens/tabs/love/love_tab.dart';
import 'package:event_palnning_project/screens/tabs/map/map_tab.dart';
import 'package:event_palnning_project/screens/tabs/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_theme_provider.dart';
import '../style/app_colors.dart';
import '../style/assets_manager.dart';

class Homescreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [HomeTab(), MapTab(), LoveTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      bottomNavigationBar: Theme(
        data:
            Theme.of(context).copyWith(canvasColor: AppColors.transparentColor),
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          // padding: EdgeInsets.zero,
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                buildBottomNavItems(
                    index: 0,
                    iconSelectedName: AssetsManager.iconHomeSelected,
                    iconName: AssetsManager.iconHome,
                    label: "home".tr()),
                buildBottomNavItems(
                    index: 1,
                    iconSelectedName: AssetsManager.iconMapSelected,
                    iconName: AssetsManager.iconMap,
                    label: "map".tr()),
                buildBottomNavItems(
                    index: 2,
                    iconSelectedName: AssetsManager.iconFavoriteSelected,
                    iconName: AssetsManager.iconFavorite,
                    label: "love".tr()),
                buildBottomNavItems(
                    index: 3,
                    iconSelectedName: AssetsManager.iconProfileSelected,
                    iconName: AssetsManager.iconProfile,
                    label: "profile".tr()),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigate to add event screen
          Navigator.of(context).pushNamed(AddEvent.routeName);
        },
        child: const Icon(
          Icons.add,
          size: 25,
          color: AppColors.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavItems(
      {required int index,
      required String iconSelectedName,
      required String iconName,
      required String label}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
            AssetImage(selectedIndex == index ? iconSelectedName : iconName)),
        label: label);
  }
}
