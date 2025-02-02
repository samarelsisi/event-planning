import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_palnning_project/models/events.dart';

class FirebaseManager {
  static CollectionReference<EventModel> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection("Events")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  // static void addEvent() {
  //   // Create an instance of EventModel
  //   EventModel event = EventModel(
  //     title: "event1",
  //     description: "family time",
  //     category: "sport",
  //     image: "sport.png",
  //     eventName: "football match",
  //     dateTime: DateTime(2025, 2, 12),
  //     // Correct DateTime initialization
  //     time: "2.5",
  //   );
  //
  //   // Add the event to Firestore
  //
  // }
  static Future<void> addEvent(EventModel event) {
    var collection = getEventsCollection();
    var doc = collection.doc(); //Autmatic id
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<QuerySnapshot<EventModel>> getEvent() {
    var collection = getEventsCollection();
    return collection.get();
  }
}
