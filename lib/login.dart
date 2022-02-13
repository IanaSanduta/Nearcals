import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginEmailController = TextEditingController();
  final loginPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.blue.shade900,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200.0,
                  child: Image.asset('resources/login.png'),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextField(
                  controller: loginEmailController,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(fontSize: 15, color: Colors.white),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: loginPassController,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter your password.',
                    hintStyle: TextStyle(fontSize: 15, color: Colors.white),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: MaterialButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: loginEmailController.text.trim(),
                          password: loginPassController.text.trim(),
                        );
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } else {
                          setState(() {});
                        }
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text('Log In',
                          style: TextStyle(fontSize: 20, color: Colors.blue)),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
