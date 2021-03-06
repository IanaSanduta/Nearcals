// ignore_for_file: file_names, avoid_print
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Image? userImageFile;
UserClass currentUser = UserClass('', '', '', 0, 0, {}, '', '');
String uID = FirebaseAuth.instance.currentUser!.uid;
CollectionReference db = FirebaseFirestore.instance.collection('UserData');
final ref = FirebaseStorage.instance
    .ref()
    .child('userImages')
    .child(uID)
    .child('userImage.jpg');

final List dbList = [
  'username',
  'userDailyCal',
  'userCurrentCal',
  'userEmail',
  'userImageURL',
  'favoritesList',
  'userLang',
  'lastLogin'
];

class UserClass {
  String? username = 'un';
  String? email = 'e';
  String? userImageURL = '';
  int? dailyCals = 0;
  int? currentCals = 0;
  Map<String, String>? favoritesList = {};
  String? userLang = '';
  String? lastLogin = '';

  UserClass(String un, String e, String ui, int dc, int cc,
      Map<String, String> map, String ul, String ll,
      {this.username,
      this.email,
      this.userImageURL,
      this.dailyCals,
      this.currentCals,
      this.favoritesList,
      this.userLang,
      this.lastLogin});

  // Pull Requests used by backend to update from the Database
  // ATTENTION PROGRAMER //
  // Use currentUser.set/getUserName(String un) instead of pull functions.
  void pullUserName(String un) {
    username = un;
  }

  // ATTENTION PROGRAMER //
  // Use currentUser.set/getEmail(String e) instead of pull functions.
  void pullEmail(String e) {
    email = e;
  }

  // ATTENTION PROGRAMER //
  // Use currentUser.set/getUserImage(String im) instead of pull functions.
  Future<void> pullUserImageURL(String ui) async {
    userImageURL = ui;
  }

  // ATTENTION PROGRAMER //
  // Use currentUser.set/getDailyCals(int dc) instead of pull functions.
  void pullDailyCals(int dc) {
    dailyCals = dc;
  }

  // ATTENTION PROGRAMER //
  // Use currentUser.set/getCurrentCals(int cc) instead of pull functions.
  void pullCurrentCals(int cc) {
    currentCals = cc;
  }

  // ATTENTION PROGRAMER //
  // Use currentUser.set/getFavoriteList(int cc) instead of pull functions.
  void pullFavoritesList(Map fl) {
    favoritesList = fl.cast<String, String>();
  }

  // ATTENTION PROGRAMER //
  // Use currentUser.set/getUserLang(String ul) instead of pull functions.
  void pullUserLang(String ul) {
    userLang = ul;
  }

  void pullLastLogin(String ll) {
    lastLogin = ll;
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
  String? getUserImageURL() {
    return userImageURL;
  }

  // currentUser.getDailyCals() will return a integer of the stored Daily Calories for the current user cause these just set local variables not the database
  int? getDailyCals() {
    return dailyCals;
  }

  // currentUser.getCurrentCals() will return a integer of the stored Current Calories for the current user cause these just set local variables not the database
  int? getCurrentCals() {
    return currentCals;
  }

  // currentUser.getFavoriteList() will return a map of the entire favorite list
  Map? getFavoriteList() {
    return favoritesList;
  }

  String? getUserLang() {
    return userLang;
  }

  String? getLastLogin() {
    return lastLogin;
  }

  // SETS //
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
  Future<void> setUserImage(File im) async {
    String imURL = '';
    ref.putFile(im);
    ref.getDownloadURL().then((value) {
      imURL = value.toString();
      db.doc(uID).update({dbList[4]: imURL});
      print(imURL);
      userImageURL = imURL;
    });
    print(userImageURL);
    uID = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot snapshot = await db.doc(uID).get();
    var data = snapshot.data() as Map;
    await currentUser.pullUserImageURL(imURL).then((value) {
      print('Image Updated');
    });
  }

  // currentUser.addFavoritesList(String key, String value) should add a value from the favorites list map
  void addFavList(String key, String favData) {
    var newFav = <String, String>{key: favData};
    favoritesList?.addEntries(newFav.entries);
    db.doc(uID).update({dbList[5]: favoritesList});
  }

  // currentUser.addFavoritesList(String key, String value) should remove a value from the favorites list map
  void removeFavList(String key) {
    favoritesList?.remove(key);
    db.doc(uID).update({dbList[5]: favoritesList});
  }

  void setUserLang(String ul) {
    db.doc(uID).update({dbList[6]: ul});
    currentUser.pullUserLang(ul);
  }

  void setLastLogin(String ll) {
    db.doc(uID).update({dbList[7]: ll});
  }

  // currentUser.clearUser() used by the prgram to clear all user values and sign out
  Future<void> clearUser() async {
    username = null;
    email = null;
    userImageURL = null;
    dailyCals = null;
    currentCals = null;
    favoritesList?.clear();
    uID = '';
    userLang = null;
    lastLogin = '';
    await FirebaseAuth.instance.signOut();
  }
}

// pullUserData() Used to load all the values from firestore into the values for the currentUser class
Future<void> pullUserData() async {
  uID = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot snapshot = await db.doc(uID).get();
  var data = snapshot.data() as Map;
  currentUser.pullUserName(data[dbList[0]] as String);
  currentUser.pullDailyCals(data[dbList[1]] as int);
  currentUser.pullCurrentCals(data[dbList[2]] as int);
  currentUser.pullEmail(data[dbList[3]] as String);
  currentUser.pullFavoritesList(data[dbList[5]] as Map);
  currentUser.pullUserImageURL(data[dbList[4]]);
  currentUser.pullUserLang(data[dbList[6]] as String);
  currentUser.pullLastLogin(data[dbList[7]] as String);
  var now = DateTime.now();
  String today = '${now.day}/${now.month}/${now.year}';
  if (currentUser.getLastLogin() != today) {
    currentUser.setLastLogin(today);
    currentUser.setCurrentCals(0);
  }

  //TODO:Remove in final
  checkUserData();
}

// checkUserData Used to check all the values in currentUser class (not really used)
void checkUserData() {
  print('Checking User Data');
  print(currentUser.getUserName());
  print(currentUser.getEmail());
  print(currentUser.getDailyCals());
  print(currentUser.getCurrentCals());
  print(currentUser.getUserImageURL());
  print(currentUser.getFavoriteList());
  print(currentUser.getUserLang());
  print(currentUser.getLastLogin());
}
