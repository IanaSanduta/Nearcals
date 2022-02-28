import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final String uID = FirebaseAuth.instance.currentUser!.uid;
final db = FirebaseFirestore.instance.collection('UserData');
final List dbList = ['username', 'userCal', 'userEmail', 'userImage'];

Future<List> userDataGet() async {
  List userData = [];
  final DocumentSnapshot snapshot = await db.doc(uID).get();
  var data = snapshot.data() as Map;
  for (int i = 0; i <= dbList.length; i++) {
    userData.add(data[dbList.elementAt(i)]);
  }

  return userData;
}

Future<List> userNameGet() {
  Future<List> userData = userDataGet();
  Future<List> userName = userData;
  return userName;
}
/*
int userCalGet() {
  String userCalData = userData.elementAt(2).toString();
  int userDailyCal = userCalData as int;
  return userDailyCal;
}

void userNameSet(String userName) {}

void userCalSet(int Cals) {}

void userImageSet(PictureLayer userImage) {}
*/