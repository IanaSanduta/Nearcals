import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBase
{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  /// Login to Firebase.
  ///
  /// Parameter [email] is the user email
  ///
  /// Parameter [password]  is the password of the user
  ///
  ///In order to retrieve the User class, follow the example:
  /// ```
  ///    var credentials = db.longIn(email,password);
  ///    credentials.then((value){
  ///       Doing something with value
  ///    }
  /// ```
  ///To handle an exception, follow the example:
  /// ```
  ///    cred.catchError((error){
  ///       print(error.message);
  ///    }
  /// ```
  Future<User?> longIn(String email,String  password) async {
      UserCredential credentials = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credentials.user;
  }

  /// Logout to Firebase.
  Future<void> longOut() async {
    await _auth.signOut();
  }

  /// Create new user to Firebase
  ///
  /// Parameter [email] is the user email
  ///
  /// Parameter [password]  is the password of the user
  ///
  ///In order to retrieve the User class, follow the example:
  /// ```
  ///    var credentials = db.createUser(email,password);
  ///    credentials.then((value){
  ///       Doing something with value
  ///    }
  /// ```
  ///To handle an exception, follow the example:
  /// ```
  ///    credentials.catchError((error){
  ///       print(error.message);
  ///    }
  /// ```
  Future<User?> createUser(String email,String  password) async {
    UserCredential credentials = await _auth.createUserWithEmailAndPassword(email:email, password: password);
    return credentials.user;
  }

  /// Getting collection
  ///
  /// Parameter [collection] is the name of the collection
  Future<Map> getCollection(String collection) async{
    CollectionReference colt =  _store.collection(collection);
    DocumentSnapshot snapshot = await colt.doc(_auth.currentUser?.uid).get();
    return snapshot.data() as Map;
  }

  ///Setting collection
  ///
 /// Parameter [collection] is the name of the collection
 ///
 /// Parameter [list] is the  data to send into the collection
  void setCollection(String collectionName, Map<String,dynamic> list) async{
    CollectionReference colt = _store.collection(collectionName);
    colt.doc(_auth.currentUser?.uid).set(list);
  }

  ///Updating collection
  ///
  /// Parameter [collection] is the name of the collection
  ///
  /// Parameter [list] is the  data to send into the collection
  void updateCollection(String collectionName, Map<String,dynamic> list) async{
    CollectionReference colt =  _store.collection(collectionName);
    colt.doc(_auth.currentUser?.uid).update(list);
  }

}