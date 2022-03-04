// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:nearcals/net/userData.dart';

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
}
