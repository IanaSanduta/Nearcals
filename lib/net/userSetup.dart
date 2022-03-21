// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> firebaseUserSetup(
    String userName, String userEmail, String userPass) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  auth.currentUser!.updateDisplayName(userName);
  int defaultCal = 2000;
  String defaultUserImage =
      'https://firebasestorage.googleapis.com/v0/b/nearcals.appspot.com/o/userImages%2Fdefault_user.png?alt=media&token=c2623d2c-2af2-47ef-8e2d-91485b35366a';
  Map<String, String> favoritesList = {};

  CollectionReference userProfile =
      FirebaseFirestore.instance.collection('UserData');
  auth
      .signInWithEmailAndPassword(email: userEmail, password: userPass)
      .then((value) {
    userProfile.doc(value.user?.uid).set({
      'username': userName,
      'userEmail': userEmail,
      'userDailyCal': defaultCal,
      'userCurrentCal': defaultCal,
      'userImage': defaultUserImage,
      'favoritesList': favoritesList
    });
  });

  return;
}
