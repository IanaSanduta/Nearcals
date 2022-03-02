import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String uID = FirebaseAuth.instance.currentUser!.uid;
CollectionReference db = FirebaseFirestore.instance.collection('UserData');
int dailyCal = userDailyCalGet();
int currentCal = 0;
String userEmail = '';
String username = '';

final dynamic userDataList = [userData(0), userDailyCalGet()];

final List dbList = [
  'username',
  'userDailyCal',
  'userCurrentCal',
  'userEmail',
  'userImage'
];

Future<void> userData(elem) async {
  DocumentSnapshot snapshot = await db.doc(uID).get();
  var data = snapshot.data() as Map;
  if (elem == 0) {
    username = data[dbList[elem]] as String;
  }
  if (elem == 1) {
    dailyCal = data[dbList[elem]];
  }
  if (elem == 2) {
    currentCal = data[dbList[elem]];
  }
  if (elem == 3) {
    userEmail = data[dbList[elem]];
  }
}

String userName() {
  userData(0);
  return username;
}

int userDailyCalGet() {
  userData(1);
  return dailyCal;
}

/*
void userNameSet(String userName) {}

void userCalSet(int Cals) {}

void userImageSet(String image) {}
*/

