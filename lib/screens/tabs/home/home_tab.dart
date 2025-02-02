import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/firebase/firebase_manager.dart';
import 'package:event_palnning_project/models/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../style/app_colors.dart';
import '../../../style/app_styles.dart';
import '../../../style/assets_manager.dart';
import '../../../widget/tabEventWidget.dart';
import 'package:event_palnning_project/providers/create_event_provider.dart';

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
    var eventProvider =
        context.watch<CreateEventsProvider>(); // Listens for changes

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        actions: [
          const Icon(Icons.sunny, color: AppColors.whiteColor),
          SizedBox(width: width * 0.02),
          GestureDetector(
            onTap: () {
              // Change language when tapped
              if (context.locale.languageCode == 'en') {
                context.setLocale(Locale('ar'));
              } else {
                context.setLocale(Locale('en'));
              }
              setState(() {}); // Forces rebuild when language changes
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.01),
              margin: EdgeInsets.only(right: width * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Text(
                context.locale.languageCode.toUpperCase(),
                style: AppStyles.bold14Primary,
              ),
            ),
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("welcome_back".tr(), style: AppStyles.regular14White),
            Text("ROUTE", style: AppStyles.bold24White),
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
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(AssetsManager.iconMap),
                    SizedBox(width: width * 0.02),
                    Text('Cairo, Egypt', style: AppStyles.medium14White),
                  ],
                ),
                DefaultTabController(
                  length: eventProvider.eventsCategories.length,
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        eventProvider.selectedEventIndex = index;
                      });
                    },
                    isScrollable: true,
                    indicatorColor: AppColors.transparentColor,
                    dividerColor: AppColors.transparentColor,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.01),
                    tabs: eventProvider.eventsCategories.map((eventName) {
                      return TabEventWidget(
                        backgroundColor: AppColors.whiteColor,
                        textSelectedStyle: AppStyles.medium16Primary,
                        textUnSelectedStyle: AppStyles.medium16White,
                        isSelected: eventProvider.selectedEventIndex ==
                            eventProvider.eventsCategories.indexOf(eventName),
                        eventName: eventName.tr(), // Translate tab names
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<QuerySnapshot<EventModel>>(
              future: FirebaseManager.getEvent(),
              builder: (context, snapshot) {
                return (Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.04),
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: height * 0.02,
                        );
                      },
                      itemBuilder: (context, index) {
                        return EventItemWidget(
                          event: snapshot.data!.docs[index].data(),
                        );
                      },
                      itemCount: snapshot.data?.docs.length ?? 0),
                )));
              })
        ],
      ),
    );
  }
}
