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
      onLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      credential.user!.sendEmailVerification();
      UserModel userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: emailAddress,
          createdAt: DateTime.now().millisecondsSinceEpoch);
      await addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      onError("Something went wrong");
      print(e);
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

  static Future<void> updateTask(EventModel model) {
    var collection = getEventsCollection();
    return collection.doc(model.id).update(model.toJson());
  }

  static logout() {
    FirebaseAuth.instance.signOut();
  }
}
