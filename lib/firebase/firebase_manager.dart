import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_palnning_project/models/events.dart';

class FirebaseManager {
  static void addEvent() {
    // Create an instance of EventModel
    EventModel event = EventModel(
      title: "event1",
      description: "family time",
      category: "sport",
      image: "sport.png",
      eventName: "football match",
      dateTime: DateTime(2025, 2, 12),
      // Correct DateTime initialization
      time: "2.5",
    );

    // Add the event to Firestore
    FirebaseFirestore.instance
        .collection("Events")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .add(event)
        .then((DocumentReference doc) {
      print('Event added with ID: ${doc.id}');
    }).catchError((error) {
      print('Failed to add event: $error');
    });
  }
}
