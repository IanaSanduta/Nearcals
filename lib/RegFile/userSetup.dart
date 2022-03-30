// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

RegUser regUser = RegUser('', '', '');

class RegUser {
  String userName = '';
  String userEmail = '';
  String userP = '';

  RegUser(String uN, String uE, String uP) {
    userName = uN;
    userEmail = uE;
    userP = uP;
  }
}

Future<void> firebaseUserSetup(
    String userName, String userEmail, String userPass) async {
  var now = DateTime.now();
  String today = '${now.day}/${now.month}/${now.year}';
  FirebaseAuth auth = FirebaseAuth.instance;
  auth.currentUser!.updateDisplayName(userName);
  int defaultDayCal = 2000;
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
      'userDailyCal': defaultDayCal,
      'userCurrentCal': 0,
      'userImageURL': defaultUserImage,
      'favoritesList': favoritesList,
      'userLang': 'English',
      'lastLogin': today
    });
  });
}
