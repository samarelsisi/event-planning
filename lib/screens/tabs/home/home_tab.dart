import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/firebase/firebase_manager.dart';
import 'package:event_palnning_project/models/events.dart';
import 'package:event_palnning_project/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../style/app_colors.dart';
import '../../../style/app_styles.dart';
import '../../../style/assets_manager.dart';
import '../../../widget/tabEventWidget.dart';
import 'package:event_palnning_project/providers/create_event_provider.dart';
import 'eventItemWidget.dart';
import 'event_details/event_details_screen.dart';

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
    var eventProvider = context.watch<CreateEventsProvider>();
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        actions: [
          const Icon(Icons.sunny, color: AppColors.whiteColor),
          SizedBox(width: width * 0.02),
          GestureDetector(
            onTap: () {
              if (context.locale.languageCode == 'en') {
                context.setLocale(const Locale('ar'));
              } else {
                context.setLocale(const Locale('en'));
              }
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
            Text(userProvider.userModel?.name ?? 'Guest',
                style: AppStyles.medium20White)
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
                  length: eventProvider.eventKeys.length,
                  child: TabBar(
                    onTap: (index) {
                      eventProvider.setSelectedEventIndex(index);
                    },
                    isScrollable: true,
                    indicatorColor: AppColors.transparentColor,
                    dividerColor: AppColors.transparentColor,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.01),
                    tabs: eventProvider
                        .getLocalizedEvents(context)
                        .map((eventName) {
                      return TabEventWidget(
                        backgroundColor: AppColors.whiteColor,
                        textSelectedStyle: AppStyles.medium16Primary,
                        textUnSelectedStyle: AppStyles.medium16White,
                        isSelected: eventProvider.selectedEventIndex ==
                            eventProvider.eventKeys.indexOf(eventProvider
                                .eventKeys
                                .firstWhere((key) => key.tr() == eventName)),
                        eventName: eventName,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot<EventModel>>(
            stream: FirebaseManager.getEvent(eventProvider.selectedEvent),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text('Error loading events',
                        style: AppStyles.medium16Primary));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text('No events available',
                        style: AppStyles.medium16Primary));
              }
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.04),
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: height * 0.02),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          EventModel event = snapshot.data!.docs[index].data();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventDetailsScreen(event: event),
                              ));
                        },
                        child: EventItemWidget(
                            event: snapshot.data!.docs[index].data()),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
