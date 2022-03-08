// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

UserClass currentUser = UserClass('', '', '', 0, 0, {});
String uID = FirebaseAuth.instance.currentUser!.uid;
CollectionReference db = FirebaseFirestore.instance.collection('UserData');

final List dbList = [
  'username',
  'userDailyCal',
  'userCurrentCal',
  'userEmail',
  'userImage',
  'favoritesList'
];

class UserClass {
  String? username = 'un';
  String? email = 'e';
  String? userImage = 'ui';
  int? dailyCals = 0;
  int? currentCals = 0;
  Map<String, String>? favoritesList = {};

  UserClass(
      String un, String e, String ui, int dc, int cc, Map<String, String> map,
      {this.username,
      this.email,
      this.userImage,
      this.dailyCals,
      this.currentCals,
      this.favoritesList});

  //Pull Requests used by backend to update from the Database
  // PROGRAMER//
  // Use currentUser.setUserName(String un) instead of pull functions.
  void pullUserName(String un) {
    username = un;
  }

  // PROGRAMER//
  // Use currentUser.setEmail(String e) instead of pull functions.
  void pullEmail(String e) {
    email = e;
  }

  // PROGRAMER//
  // Use currentUser.setUserImage(String im) instead of pull functions.
  void pullUserImage(String im) {
    userImage = im;
  }

  // PROGRAMER//
  // Use currentUser.setDailyCals(int dc) instead of pull functions.
  void pullDailyCals(int dc) {
    dailyCals = dc;
  }

  // PROGRAMER//
  // Use currentUser.setCurrentCals(int cc) instead of pull functions.
  void pullCurrentCals(int cc) {
    currentCals = cc;
  }

  // PROGRAMER//
  // Use currentUser.setFavoriteList(int cc) instead of pull functions.
  void pullFavoritesList(Map fl) {
    favoritesList = fl.cast<String, String>();
  }

  // GETS //
  // get requests used by programers to get specific values from currentUser

  // currentUser.getUserName() will return a String of the stored Username for the current user cause these just set local variables not the database
  String? getUserName() {
    return username;
  }

  // currentUser.getEmail() will return a String of the stored Email for the current user cause these just set local variables not the database
  String? getEmail() {
    return email;
  }

  // currentUser.getUserImage() will return a String of the stored User Image for the current user cause these just set local variables not the database
  //TODO: need to implement image storage in firestore
  String? getUserImage() {
    return userImage;
  }

  // currentUser.getDailyCals() will return a integer of the stored Daily Calories for the current user cause these just set local variables not the database
  int? getDailyCals() {
    return dailyCals;
  }

  // currentUser.getCurrentCals() will return a integer of the stored Current Calories for the current user cause these just set local variables not the database
  int? getCurrentCals() {
    return currentCals;
  }

  //currentUser.getFavoriteList() will return a map of the entire favorite list
  Map? getFavoriteList() {
    return favoritesList;
  }

  //SETS//
  // sets used by programmers to set and update the database.
  // currentUser.setUserName(value) updates the firestore and firebase.auth values for the current users display/username to the value given
  void setUserName(String un) {
    db.doc(uID).update({dbList[0]: un});
    FirebaseAuth.instance.currentUser?.updateDisplayName(un);
    currentUser.pullUserName(un);
  }

  // currentUser.setUserName(value) updates the firestore and firebase.auth values for the current users display/username to the value given
  void setEmail(String e) {
    db.doc(uID).update({dbList[3]: e});
    FirebaseAuth.instance.currentUser?.updateEmail(e);
    currentUser.pullEmail(e);
  }

  // currentUser.setUserName(value) updates the firestore and firebase.auth values for the current users display/username to the value given
  void setCurrentCals(int cc) {
    db.doc(uID).update({dbList[2]: cc});
    currentUser.pullCurrentCals(cc);
  }

  // currentUser.setUserName(value) updates the firestore and firebase.auth values for the current users display/username to the value given
  void setDailyCals(int dc) {
    db.doc(uID).update({dbList[1]: dc});
    currentUser.pullDailyCals(dc);
  }

  // currentUser.setUserName(value) updates the firestore and firebase.auth values for the current users display/username to the value given
  void setUserImage(String im) {
    db.doc(uID).update({dbList[4]: im});
    currentUser.pullUserImage(im);
  }

  // TODO: Needs to be tested when we have the UI for it (probably doesnt work)
  // currentUser.addFavoritesList(String key, String value) should add a value from the favorites list map
  void addFavoritesList(String key, String favData) {
    var newFav = <String, String>{key: favData};
    favoritesList?.addEntries(newFav.entries);
    db.doc(uID).update({dbList[5]: favoritesList});
  }

  // TODO: Needs to be tested when we have the UI for it (probably doesnt work)
  // currentUser.addFavoritesList(String key, String value) should remove a value from the favorites list map
  void removeFavoritesList(String key) {
    favoritesList?.remove(key);
    db.doc(uID).update({dbList[5]: favoritesList});
  }

  // currentUser.clearUser() used by the prgram to clear all user values and sign out
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

// pullUserData() Used to load all the values from firestore into the values for the currentUser class
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
  while (currentUser.getFavoriteList() == null) {
    currentUser.pullFavoritesList(data[dbList[5]] as Map);
  }
  print(currentUser.getFavoriteList());
}

// checkUserData Used to check all the values in currentUser class
void checkUserData() {
  print('Check User Data');
  print(currentUser.getUserName());
  print(currentUser.getEmail());
  print(currentUser.getDailyCals());
  print(currentUser.getCurrentCals());
  print(currentUser.getUserImage());
  print(currentUser.getFavoriteList());
}
