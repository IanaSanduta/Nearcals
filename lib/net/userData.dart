import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nearcals/classes/userClass.dart';
import 'dart:async';

UserClass currentUser = UserClass('', '', '', 0, 0);
String uID = FirebaseAuth.instance.currentUser!.uid;
CollectionReference db = FirebaseFirestore.instance.collection('UserData');
final List dbList = [
  'username',
  'userDailyCal',
  'userCurrentCal',
  'userEmail',
  'userImage'
];

Future<void> pullUserData() async {
  DocumentSnapshot snapshot = await db.doc(uID).get();
  var data = snapshot.data() as Map;

  while (currentUser.getUserName() == null) {
    currentUser.pullUserName(data[dbList[0]] as String);
  }
  print(currentUser.getUserName());
  while (currentUser.getDailyCals() == null) {
    currentUser.pullDailyCals(data[dbList[1]] as int);
  }
  print(currentUser.getDailyCals());
  while (currentUser.getCurrentCals() == null) {
    currentUser.pullCurrentCals(data[dbList[2]] as int);
  }
  print(currentUser.getCurrentCals());
  while (currentUser.getEmail() == null) {
    currentUser.pullEmail(data[dbList[3]] as String);
  }
  print(currentUser.getEmail());
  while (currentUser.getUserImage() == null) {
    currentUser.pullUserImage(data[dbList[4]] as String);
  }
  print(currentUser.getUserImage());
}

void checkUserData() {
  print('Check User Data');
  print(currentUser.getUserName());
  print(currentUser.getEmail());
  print(currentUser.getDailyCals());
  print(currentUser.getCurrentCals());
  print(currentUser.getUserImage());
}
