import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../style/app_colors.dart';
import '../../../style/app_styles.dart';
import '../../../style/assets_manager.dart';

class EventItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.31,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(AssetsManager.birthdayImage))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.002),
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.008),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor),
            child: Column(
              children: [
                Text(
                  "",
                  style: AppStyles.bold20Primary,
                ),
                Text(
                  " ",
                  style: AppStyles.bold20Primary,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.01),
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.008),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Birthday",
                    style: AppStyles.bold14Black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    //todo: update favorite
                  },
                  child: Image.asset(
                    // .isFavorite == true ?
                    // AssetsManager.iconFavoriteSelected
                    //     :
                    AssetsManager.iconFavorite,
                    color: AppColors.primaryLight,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
