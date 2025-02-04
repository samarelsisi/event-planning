import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/firebase/firebase_manager.dart';
import 'package:event_palnning_project/providers/app_theme_provider.dart';
import 'package:event_palnning_project/providers/create_event_provider.dart';
import 'package:event_palnning_project/screens/tabs/home/event_edit/event_edit_screen.dart';
import 'package:event_palnning_project/widget/custome_test_filed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/events.dart';
import '../../../../style/app_colors.dart';
import '../../../../style/app_styles.dart';
import '../../../../style/assets_manager.dart';

class EventDetailsScreen extends StatelessWidget {
  static const routeName = "event_details_screen";
  final EventModel event;

  EventDetailsScreen({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CreateEventsProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print("event time===== ${event.time}");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryLight),
        title: Text(
          "event_details".tr(),
          style: AppStyles.medium20Primary,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventEditScreen(eventModel: event),
                  ));
            },
            icon: Icon(Icons.edit_outlined),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: () {
              FirebaseManager.deleteEvent(event.id);
              Navigator.pop(context);
            },
            icon: ImageIcon(
              AssetImage(AssetsManager.delete_icon),
              color: AppColors.redColor,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(event.image),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(event.title, style: AppStyles.medium20Primary),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.02),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 2)),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.01),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      AssetsManager.iconDate,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.dateTime.toString().substring(0, 10),
                          style: AppStyles.medium16Primary,
                        ),
                        Text(
                          event.time.toString(),
                          style: AppStyles.medium16Black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.02),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 2)),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.01),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(AssetsManager.iconLocation),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Expanded(
                    child: Text(
                      "Cairo , Egypt",
                      style: AppStyles.medium16Primary,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.primaryLight,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/map.png",
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "description".tr(),
              style: AppStyles.semi20Primary,
            ),
            Text(
              event.description,
              style: AppStyles.medium16Black,
            )
          ]),
        ),
      ),
    );
  }
}
