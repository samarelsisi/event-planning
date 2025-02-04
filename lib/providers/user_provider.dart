import 'package:event_palnning_project/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_manager.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    userModel = await FirebaseManager.readUser();
    notifyListeners();
  }
}
