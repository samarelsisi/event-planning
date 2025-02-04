import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/models/events.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class FirebaseManager {
  static CollectionReference<EventModel> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection("Events")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (model, _) {
        return model.toJson();
      },
    );
  }

  static Future<void> addEvent(EventModel event) {
    var collection = getEventsCollection();
    var doc = collection.doc(); // Automatic ID
    event.id = doc.id;
    return doc.set(event);
  }

  static Stream<QuerySnapshot<EventModel>> getEvent(String categoryName) {
    var collection = getEventsCollection();

    if (categoryName.toLowerCase() == "all") {
      return collection
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy("dateTime") // Ensure "dateTime" is indexed in Firestore
          .snapshots();
    } else {
      print(categoryName.tr());
      return collection
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("eventName",
              isEqualTo: categoryName.tr()) // Fixed filtering condition
          .orderBy("dateTime") // Requires a composite index in Firestore
          .snapshots();
    }
  }

  static Future<void> deleteEvent(String id) {
    var collection = getEventsCollection();
    return collection.doc(id).delete();
  }

  static Future<void> addUser(UserModel user) {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> createAccount(
      String name,
      String emailAddress,
      String password,
      Function onLoading,
      Function onSuccess,
      Function onError) async {
    try {
      // Trigger loading indicator
      onLoading();

      // Attempt to create a user with Firebase Authentication
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Send email verification after successful registration
      await credential.user!.sendEmailVerification();

      // Create a UserModel object to store user information in Firestore
      UserModel userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: emailAddress,
          createdAt: DateTime.now().millisecondsSinceEpoch);

      // Save user information in Firestore
      await addUser(userModel);

      // Call onSuccess callback
      onSuccess();
    } on FirebaseAuthException catch (e) {
      // Firebase-specific errors
      if (e.code == 'weak-password') {
        onError("Your password is too weak. Please choose a stronger one.");
      } else if (e.code == 'email-already-in-use') {
        onError(
            "This email address is already in use. Please try another one.");
      } else if (e.code == 'invalid-email') {
        onError("The email address is not valid. Please enter a correct one.");
      } else {
        onError(e.message ?? "An error occurred while creating the account.");
      }
    } catch (e) {
      // Catching unexpected errors
      onError("Something went wrong. Please try again.");
      print(e); // Log the error for debugging purposes
    }
  }

  static Future<void> login(String email, String password, Function onLoading,
      Function onSuccess, Function onError) async {
    try {
      onLoading();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      onSuccess();
    } on FirebaseAuthException {
      onError("Wrong mail or password");
    }
  }

  static Future<UserModel?> readUser() async {
    var collection = getUsersCollection();
    DocumentSnapshot<UserModel> docRef =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docRef.data();
  }

  static Future<void> updateEvent(EventModel model) {
    var collection = getEventsCollection();
    return collection.doc(model.id).update(model.toJson());
  }

  static logout() {
    FirebaseAuth.instance.signOut();
  }
}
