import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> firebaseUserSetup(
    String userName, String userEmail, String userPass) async {
  CollectionReference userProfile =
      FirebaseFirestore.instance.collection('Users');

  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: userEmail, password: userPass);

  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  int defaultCal = 2000;
  userProfile.add({
    'uid': uid,
    'username': userName,
    'userEmail': userEmail,
    'userCal': defaultCal,
    'userImage': null
  });
  return;
}
