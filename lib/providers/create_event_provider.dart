import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/main.dart';
import 'package:flutter/material.dart';

class CreateEventsProvider extends ChangeNotifier {
  int selectedEventIndex = 0;

  List<String> eventsCategories = [
    "all".tr(),
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

  Map<String, String> localizationEnMap = {
    "all".tr(): 'All',
    "sport".tr(): 'Sport',
    "birthday".tr(): 'Birthday',
    "meeting".tr(): 'Meeting',
    "gaming".tr(): 'Gaming',
    "workshop".tr(): 'WorkShop',
    "book_club ".tr(): 'Book Club',
    "exhibition".tr(): 'Exhibition',
    "holiday ".tr(): 'Holiday',
    "eating ".tr(): 'Eating'
  };
  Map<String, String> localizationArMap = {
    "all".tr(): "الكل",
    "sport".tr(): 'رياضة',
    "birthday".tr(): 'عيد الميلاد',
    "meeting".tr(): 'اجتماع',
    "gaming".tr(): 'ألعاب',
    "workshop".tr(): 'ورشة عمل',
    "book_club ".tr(): 'نادي الكتاب',
    "exhibition".tr(): 'معرض',
    "holiday ".tr(): 'إجازة',
    "eating ".tr(): 'تناول الطعام'
  };
  var selectedDate = DateTime.now();

  String get imageName => eventsCategories[selectedEventIndex];

  String get selectedEvent => eventsCategories[selectedEventIndex];

  changeSelectedDate(DateTime date) {
    selectedDate = date;

    notifyListeners();
  }

  changeEventType(int index) {
    selectedEventIndex = index;

    notifyListeners();
  }

  void setSelectedEventIndex(int index) {
    selectedEventIndex = index;
    notifyListeners();
  }
}
