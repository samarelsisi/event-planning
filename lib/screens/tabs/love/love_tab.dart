import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_styles.dart';
import '../../../style/assets_manager.dart';
import '../../../widget/custome_test_filed.dart';
import '../home/eventItemWidget.dart';

class LoveTab extends StatelessWidget {
  const LoveTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // if(eventListProvider.favoriteEventList.isEmpty){
    //   eventListProvider.getFavoriteEvents(userProvider.currentUser!.id);
    // }
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
        ),
        child: Column(
          children: [
            CustomTextField(
              hintStyle: AppStyles.bold14Primary,
              borderColor: AppColors.primaryLight,
              prefixIcon: Image.asset(AssetsManager.iconSearch),
              hintText: "search_event".tr(),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
                child: Center(
              child: Text(
                "no_favorite_events_found".tr(),
                style: AppStyles.medium16Black,
              ),
            ))
            // ListView.separated(
            //   separatorBuilder: (context,index){
            //     return SizedBox(
            //       height: height*0.02,
            //     );
            //   },
            //   padding: EdgeInsets.zero,
            //   itemBuilder: (context,index){
            //     return  EventItemWidget(event: eventListProvider.favoriteEventList[index],);
            //   },
            //   itemCount: eventListProvider.favoriteEventList.length,))
          ],
        ),
      ),
    );
  }
}
