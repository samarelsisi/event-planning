import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  static const String collectionName = 'Events';
  String id;
  String userId;
  String title;
  String description;
  String image;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;
  String category;
  bool isDone;

  EventModel({
    this.id = "",
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.eventName,
    required this.dateTime,
    required this.time,
    this.isFavorite = false,
    this.isDone = false,
  });

  // Constructor: JSON -> Object
  EventModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String? ?? '',
          userId: json['userId'] as String? ?? '',
          title: json['title'] as String? ?? '',
          description: json['description'] as String? ?? '',
          category: json['category'] as String? ?? '',
          image: json['image'] as String? ?? '',
          eventName: json['eventName'] as String? ?? '',
          dateTime:
              (json['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
          time: json['time'] as String? ?? 'No time',
          isDone: json['isDone'] as bool ?? false,
          isFavorite: json['isFavorite'] as bool ?? false,
        );

  // Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "description": description,
      "category": category,
      "image": image,
      "eventName": eventName,
      "dateTime": dateTime,
      "time": time,
      "isDone": isDone,
      "isFavorite": isFavorite,
    };
  }
}
