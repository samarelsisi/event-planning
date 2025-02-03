import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/firebase/firebase_manager.dart';
import 'package:event_palnning_project/models/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../providers/create_event_provider.dart';
import '../../../../style/app_colors.dart';
import '../../../../style/app_styles.dart';
import '../../../../style/assets_manager.dart';
import '../../../../widget/custom_elevated_button.dart';
import '../../../../widget/custome_choose_date_or_Time.dart';
import '../../../../widget/custome_test_filed.dart';
import '../../../../widget/tabEventWidget.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = 'add_event';

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  //todo: save image , save event name
  int selectedIndex = 0;

  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController(); // title
  var descriptionController = TextEditingController(); // desc
  DateTime? selectedDate;

  String formatedDate = '';
  TimeOfDay? selectedTime;

  String? formatedTime;

  /// =>
  String selectedImage = '';

  /// image
  String selectedEventName = '';

  /// event name

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CreateEventsProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<String> eventsNameList = [
      "sport".tr(),
      " birthday".tr(),
      "meeting".tr(),
      "gaming".tr(),
      "workshop".tr(),
      "book_club".tr(),
      "exhibition".tr(),
      " holiday".tr(),
      " eating".tr(),
    ];
    List<String> imageSelectedNameList = [
      AssetsManager.sportImage,
      AssetsManager.birthdayImage,
      AssetsManager.meetingImage,
      AssetsManager.gamingImage,
      AssetsManager.workshopImage,
      AssetsManager.bookClubImage,
      AssetsManager.exhibitionImage,
      AssetsManager.holidayImage,
      AssetsManager.eatingImage,
    ];

    selectedImage = imageSelectedNameList[selectedIndex];
    selectedEventName = eventsNameList[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryLight),
        title: Text(
          "create_event".tr(),
          style: AppStyles.medium20Primary,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                    // mapList[eventsNameList[selectedIndex]]!
                    imageSelectedNameList[selectedIndex]),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                height: height * 0.05,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          provider.changeEventType(index);
                          setState(() {});
                        },
                        child: TabEventWidget(
                            borderColor: AppColors.primaryLight,
                            backgroundColor: AppColors.primaryLight,
                            textSelectedStyle: AppStyles.medium16White,
                            textUnSelectedStyle: AppStyles.medium16Primary,
                            isSelected: selectedIndex == index,
                            eventName: eventsNameList[index]),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: width * 0.02,
                      );
                    },
                    itemCount: eventsNameList.length),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "title".tr(),
                        style: themeProvider.appTheme == ThemeMode.light
                            ? AppStyles.medium16Primary
                            : AppStyles.medium16White,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomTextField(
                        borderColor: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.greyColor
                            : AppColors.whiteColor,
                        controller: titleController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter event title'; // invalid
                          }
                          return null; // valid
                        },
                        hintText: "event_title".tr(),
                        prefixIcon: Image.asset(AssetsManager.iconEdit),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "description".tr(),
                        style: themeProvider.appTheme == ThemeMode.light
                            ? AppStyles.medium16Primary
                            : AppStyles.medium16White,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomTextField(
                        controller: descriptionController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter event description'; // invalid
                          }
                          return null; // valid
                        },
                        maxLines: 4,
                        hintText: "event_description".tr(),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      ChooseDateOrTime(
                          iconName: AssetsManager.iconDate,
                          eventDateOrTime: " event_date".tr(),
                          chooseDateOrTime: selectedDate == null
                              ? "choose_date".tr()
                              : DateFormat('dd/MM/yyyy').format(selectedDate!),
                          onChooseDateOrTime: chooseDate),
                      ChooseDateOrTime(
                          iconName: AssetsManager.iconTime,
                          eventDateOrTime: "event_time".tr(),
                          chooseDateOrTime: selectedTime == null
                              ? " choose_time".tr()
                              : formatedTime!,
                          onChooseDateOrTime: chooseTime),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "location".tr(),
                        style: AppStyles.medium16Black,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.01),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: AppColors.primaryLight, width: 2)),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.01),
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
                                "choose_event_location".tr(),
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
                      CustomElevatedButton(
                          onButtonClicked: () {
                            EventModel event = EventModel(
                                title: titleController.text,
                                description: descriptionController.text,
                                category: selectedEventName,
                                image: selectedImage,
                                eventName: selectedEventName,
                                dateTime: selectedDate as DateTime,
                                time: selectedTime!.format(context));
                            FirebaseManager.addEvent(event).then((value) {
                              Navigator.pop(context);
                            });
                          },
                          text: "add_event".tr())
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chooseDate;
    selectedDate = DateFormat('dd/MM/yyyy').format(chooseDate!) as DateTime?;
    var provider = Provider.of<CreateEventsProvider>(context, listen: false);
    provider.changeSelectedDate(selectedDate as DateTime);
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedTime = chooseTime;
    formatedTime = selectedTime!.format(context);
    setState(() {});
  }
}
