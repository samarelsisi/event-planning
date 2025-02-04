import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateEventsProvider extends ChangeNotifier {
  int selectedEventIndex = 0;

  final List<String> eventKeys = [
    "all",
    "sport",
    "birthday",
    "meeting",
    "gaming",
    "workshop",
    "book_club",
    "exhibition",
    "holiday",
    "eating",
  ];

  DateTime selectedDate = DateTime.now();

  String get selectedEvent {
    if (selectedEventIndex < 0 || selectedEventIndex >= eventKeys.length) {
      return "all"; // Default to "all" if index is invalid
    }
    return eventKeys[selectedEventIndex];
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setSelectedEventIndex(int index) {
    if (index >= 0 && index < eventKeys.length) {
      selectedEventIndex = index;
      notifyListeners();
    }
  }

  List<String> getLocalizedEvents(BuildContext context) {
    return eventKeys.map((key) => key.tr()).toList();
  }
}
