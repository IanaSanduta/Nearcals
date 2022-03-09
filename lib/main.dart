// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print(FirebaseAuth.instance.currentUser?.uid);

  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(
      //Define splash effects colors
      splashColor: Colors.blueAccent.shade100,
      highlightColor: Colors.black.withOpacity(0.1),

      //Define the default text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        headline2: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.5,
        ),
      ),

      //Define the default Elevated Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.blue,
            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            minimumSize: const Size(200, 42),
          )),

      //Define the default InputDecoration of TextField
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 15, color: Colors.white),
        labelStyle: TextStyle(fontSize: 15, color: Colors.white),
        errorStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      ),

      //Define AppBar Style
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        toolbarTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  //Start of the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'NearCals',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Image.asset('resources/logo.png'),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegScreen())),
                      child: const Text('Sign Up'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen())),
                      child: const Text('Log In'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
