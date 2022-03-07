// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class UserClass {
  String? username = 'un';
  String? email = 'e';
  String? userImage = 'ui';
  int? dailyCals = 0;
  int? currentCals = 0;

  UserClass(String un, String e, String ui, int dc, int cc,
      {this.username,
      this.email,
      this.userImage,
      this.dailyCals,
      this.currentCals});

  //Pull Requests used by backend to update from the Database
  void pullUserName(String un) {
    username = un;
  }

  void pullEmail(String e) {
    email = e;
  }

  void pullUserImage(String im) {
    userImage = im;
  }

  void pullDailyCals(int dc) {
    dailyCals = dc;
  }

  void pullCurrentCals(int cc) {
    currentCals = cc;
  }

  //Get Requests used by programers to get specific values from currentUser
  String? getUserName() {
    return username;
  }

  String? getEmail() {
    return email;
  }

  String? getUserImage() {
    return userImage;
  }

  int? getDailyCals() {
    return dailyCals;
  }

  int? getCurrentCals() {
    return currentCals;
  }

  //Set used by programmers to set and update the database.
  void setUserName(String un) {
    db.doc(uID).update({dbList[0]: un});
    FirebaseAuth.instance.currentUser?.updateDisplayName(un);
    currentUser.pullUserName(un);
    pullUserData();
  }

  void setEmail(String e) {
    db.doc(uID).update({dbList[3]: e});
    FirebaseAuth.instance.currentUser?.updateEmail(e);
    currentUser.pullEmail(e);
    pullUserData();
  }

  void setCurrentCals(int cc) {
    db.doc(uID).update({dbList[2]: cc});
    currentUser.pullCurrentCals(cc);
    pullUserData();
  }

  void setDailyCals(int dc) {
    db.doc(uID).update({dbList[1]: dc});
    currentUser.pullDailyCals(dc);
    pullUserData();
  }

  void setUserImage(String ui) {
    db.doc(uID).update({dbList[4]: ui});
    currentUser.pullUserImage(ui);
    pullUserData();
  }

  Future<void> clearUser() async {
    username = null;
    email = null;
    userImage = null;
    dailyCals = null;
    currentCals = null;
    uID = '';
    await FirebaseAuth.instance.signOut();
  }
}

Future<void> pullUserData() async {
  uID = FirebaseAuth.instance.currentUser!.uid;
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
