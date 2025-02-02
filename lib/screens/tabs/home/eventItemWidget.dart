import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/models/events.dart';
import 'package:event_palnning_project/providers/create_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../style/app_colors.dart';
import '../../../style/app_styles.dart';
import '../../../style/assets_manager.dart';

class EventItemWidget extends StatelessWidget {
  EventModel event;

  EventItemWidget({required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<CreateEventsProvider>(context);
    // var userProvider = Provider.of<UserProvider>(context);
    return Container(
      height: height * 0.31,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(event.image))),
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
                  event.dateTime.day.toString(),
                  style: AppStyles.bold20Primary,
                ),
                Text(
                  DateFormat('MMM').format(event.dateTime),
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
                    event.title,
                    style: AppStyles.bold14Black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    //todo: update favorite
                    // eventListProvider.updateFavoriteEvent(event,userProvider.currentUser!.id);
                  },
                  child: Image.asset(
                    event.isFavorite == true
                        ? AssetsManager.iconFavoriteSelected
                        : AssetsManager.iconFavorite,
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
