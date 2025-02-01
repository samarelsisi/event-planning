import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../style/app_colors.dart';
import '../../../style/app_styles.dart';
import '../../../style/assets_manager.dart';
import '../../../widget/tabEventWidget.dart';
import 'eventItemWidget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        actions: [
          const Icon(
            Icons.sunny,
            color: AppColors.whiteColor,
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.01),
            margin: EdgeInsets.only(
              right: width * 0.02,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor),
            child: Text(
              'EN',
              style: AppStyles.bold14Primary,
            ),
          )
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "welcome".tr(),
              style: AppStyles.regular14White,
            ),
            Text(
              "ROUTE",
              style: AppStyles.bold24White,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.14,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.01),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35))),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(AssetsManager.iconMap),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      'Cairo, Egypt',
                      style: AppStyles.medium14White,
                    )
                  ],
                ),
                DefaultTabController(
                    length: 7,
                    child: TabBar(
                      onTap: (index) {},
                      isScrollable: true,
                      indicatorColor: AppColors.transparentColor,
                      dividerColor: AppColors.transparentColor,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.symmetric(
                          horizontal: width * 0.02, vertical: height * 0.01),
                      tabs: [
                        Tab(
                          text: "HOME",
                        ),
                        Tab(
                          text: "sport",
                        )
                      ],
                    ))
              ],
            ),
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.04),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: height * 0.02,
                      );
                    },
                    itemBuilder: (context, index) {},
                    itemCount: 10,
                  )))
        ],
      ),
    );
  }
}
