import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/models/events.dart';
import 'package:event_palnning_project/style/app_styles.dart';
import 'package:event_palnning_project/widget/custom_elevated_button.dart';
import 'package:event_palnning_project/widget/tabEventWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../firebase/firebase_manager.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../providers/create_event_provider.dart';
import '../../../../style/app_colors.dart';
import '../../../../style/assets_manager.dart';
import '../../../../widget/custome_choose_date_or_Time.dart';
import '../../../../widget/custome_test_filed.dart';

class EventEditScreen extends StatefulWidget {
  static const routeName = "edit event screen";
  final EventModel eventModel;

  const EventEditScreen({required this.eventModel, super.key});

  @override
  State<EventEditScreen> createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  int selectedIndex = 0;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? formattedTime;
  String selectedImage = '';
  String selectedEventName = '';

  @override
  void initState() {
    super.initState();
    // Initialize with existing event values
    titleController.text = widget.eventModel.title;
    descriptionController.text = widget.eventModel.description;
    selectedDate = widget.eventModel.dateTime;
    formattedTime = widget.eventModel.time;
    selectedEventName = widget.eventModel.eventName;
    ;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CreateEventsProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    List<String> eventsNameList = [
      "sport".tr(),
      "birthday".tr(),
      "meeting".tr(),
      "gaming".tr(),
      "workshop".tr(),
      "book_club".tr(),
      "exhibition".tr(),
      "holiday".tr(),
      "eating".tr(),
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
    selectedIndex = eventsNameList.indexOf(widget.eventModel.eventName);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryLight),
        title: Text(
          "edit_event".tr(),
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
                child: Image.asset(selectedImage),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                height: height * 0.05,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: TabEventWidget(
                        borderColor: AppColors.primaryLight,
                        backgroundColor: AppColors.primaryLight,
                        textSelectedStyle: AppStyles.medium16White,
                        textUnSelectedStyle: AppStyles.medium16Primary,
                        isSelected: selectedIndex == index,
                        eventName: eventsNameList[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(width: width * 0.02),
                  itemCount: eventsNameList.length,
                ),
              ),
              SizedBox(height: height * 0.02),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      controller: titleController,
                      validator: (text) => text == null || text.isEmpty
                          ? "Title cannot be empty"
                          : null,
                      hintText: "event_title".tr(),
                      labelText: "title".tr(),
                      prefixIcon: Image.asset(AssetsManager.iconEdit),
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: descriptionController,
                      validator: (text) => text == null || text.isEmpty
                          ? "Description cannot be empty"
                          : null,
                      maxLines: 4,
                      hintText: "event_description".tr(),
                      labelText: "description".tr(),
                    ),
                    SizedBox(height: height * 0.02),
                    ChooseDateOrTime(
                      iconName: AssetsManager.iconDate,
                      eventDateOrTime: " event_date".tr(),
                      chooseDateOrTime: selectedDate != null
                          ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                          : widget.eventModel.dateTime
                              .toString()
                              .substring(0, 10),
                      onChooseDateOrTime: chooseDate,
                    ),
                    ChooseDateOrTime(
                      iconName: AssetsManager.iconTime,
                      eventDateOrTime: "event_time".tr(),
                      chooseDateOrTime: selectedTime != null
                          ? formattedTime!
                          : widget.eventModel.time,
                      onChooseDateOrTime: chooseTime,
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      onButtonClicked: () {
                        if (formKey.currentState!.validate()) {
                          final updatedEvent = EventModel(
                            id: widget.eventModel.id,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            title: titleController.text,
                            description: descriptionController.text,
                            category: selectedEventName,
                            image: selectedImage,
                            eventName: selectedEventName,
                            dateTime:
                                selectedDate ?? widget.eventModel.dateTime,
                            time: formattedTime ?? widget.eventModel.time,
                          );
                          FirebaseManager.updateEvent(updatedEvent)
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        }
                      },
                      text: "update_event".tr(),
                    )
                  ],
                ),
              ),
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
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (chooseDate != null) {
      setState(() {
        selectedDate = chooseDate;
      });
    }
  }

  void chooseTime() async {
    var chooseTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (chooseTime != null) {
      setState(() {
        selectedTime = chooseTime;
        formattedTime = selectedTime!.format(context);
      });
    }
  }
}
