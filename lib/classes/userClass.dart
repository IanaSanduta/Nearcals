// ignore_for_file: file_names, avoid_print
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nearcals/classes/firebase_file.dart';
import 'package:path_provider/path_provider.dart';

Image? userImageFile;
UserClass currentUser = UserClass('', '', '', 0, 0, {});
String uID = FirebaseAuth.instance.currentUser!.uid;
CollectionReference db = FirebaseFirestore.instance.collection('UserData');

final List dbList = [
  'username',
  'userDailyCal',
  'userCurrentCal',
  'userEmail',
  'userImageURL',
  'favoritesList'
];

class UserClass {
  String? username = 'un';
  String? email = 'e';
  String? userImageURL;
  int? dailyCals = 0;
  int? currentCals = 0;
  Map<String, String>? favoritesList = {};

  UserClass(
      String un, String e, String ui, int dc, int cc, Map<String, String> map,
      {this.username,
      this.email,
      this.userImageURL,
      this.dailyCals,
      this.currentCals,
      this.favoritesList});

  // Pull Requests used by backend to update from the Database
  // ATTENTION PROGRAMER //
  // Use currentUser.setUserName(String un) instead of pull functions.
  void pullUserName(String un) {
    username = un;
  }

  // ATTENTION PROGRAMER //
  // Use currentUser.setEmail(String e) instead of pull functions.
  void pullEmail(String e) {
    email = e;
  }

  // ATTENTION PROGRAMER //
  // Use currentUser.setUserImage(String im) instead of pull functions.
  //TODO: Make so that it pulls image file from firestore and stores it in the local resource folder
  Future<List<FirebaseFile>> pullUserFiles() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('userImages')
        .child(uID)
        .child(currentUser.getUserName() as String);
    final results = await ref.listAll();
    final urls = await _getDownloadLink(results.items);
    return urls
        .asMap()
        .map((index, url) {
          final ref = results.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);
          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  Future<List<String>> _getDownloadLink(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  Future<void> pullUserImage() async {
    Future<List<FirebaseFile>> files = pullUserFiles();
    for (FirebaseFile file in files as List) {
      await downloadFile(file.ref);
    }
  }

  static Future downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${uID}userImage.jpg');
    await ref.writeToFile(file);
  }

  // ATTENTION PROGRAMER //
  // Use currentUser.setDailyCals(int dc) instead of pull functions.
  void pullDailyCals(int dc) {
    dailyCals = dc;
  }

  // ATTENTION PROGRAMER //
  // Use currentUser.setCurrentCals(int cc) instead of pull functions.
  void pullCurrentCals(int cc) {
    currentCals = cc;
  }

  // ATTENTION PROGRAMER //
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

  // TODO: need to implement image storage in firestore
  // TODO: Make so that programmer pulls image file from local storage
  // currentUser.getUserImage() will return a String of the stored User Image for the current user cause these just set local variables not the database
  Future<String?> getUserImage() async {
    final dir = await getApplicationDocumentsDirectory();
    final userImageFile = '${dir.path}/${uID}userImage.jpg';

    return userImageFile;
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

  // TODO: Make so that it uplaods new image file to firestore and sets local stored image as new user image
  // currentUser.setUserName(value) updates the firestore and firebase.auth values for the current users display/username to the value given
  Future<void> setUserImage(File im) async {
    final dir = await getApplicationDocumentsDirectory();
    var uIF = '${dir.path}/${uID}userImage.jpg';

    userImageFile = uIF as Image?;
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

  // currentUser.clearUser() used by the prgram to clear all user values and sign out
  Future<void> clearUser() async {
    username = null;
    email = null;
    userImageURL = null;
    userImageFile = null;
    dailyCals = null;
    currentCals = null;
    favoritesList?.clear();
    uID = '';
    await FirebaseAuth.instance.signOut();
  }
}

// TODO: Makes so that it workds with new commands
// pullUserData() Used to load all the values from firestore into the values for the currentUser class
Future<void> pullUserData() async {
  uID = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot snapshot = await db.doc(uID).get();
  var data = snapshot.data() as Map;
  currentUser.username = null;
  currentUser.email = null;
  currentUser.userImageURL = null;
  userImageFile = null;
  currentUser.dailyCals = null;
  currentUser.currentCals = null;
  currentUser.favoritesList?.clear();
  currentUser.pullUserName(data[dbList[0]] as String);
  currentUser.pullDailyCals(data[dbList[1]] as int);
  currentUser.pullCurrentCals(data[dbList[2]] as int);
  currentUser.pullEmail(data[dbList[3]] as String);
  currentUser.pullFavoritesList(data[dbList[5]] as Map);
  currentUser.pullUserImage();
  //TODO:Remove in final
  checkUserData();
}

// checkUserData Used to check all the values in currentUser class (not really used)
void checkUserData() {
  print('Check User Data');
  print(currentUser.getUserName());
  print(currentUser.getEmail());
  print(currentUser.getDailyCals());
  print(currentUser.getCurrentCals());
  print(currentUser.getUserImage());
  print(currentUser.getFavoriteList());
}
