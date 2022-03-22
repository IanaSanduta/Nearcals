// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> firebaseUserSetup(
    String userName, String userEmail, String userPass) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  auth.currentUser!.updateDisplayName(userName);
  int defaultCal = 2000;
  String defaultUserImage =
      'https://firebasestorage.googleapis.com/v0/b/nearcals.appspot.com/o/default_user.png?alt=media&token=56635ce8-973a-437d-9de5-d8de3ef24673';
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
