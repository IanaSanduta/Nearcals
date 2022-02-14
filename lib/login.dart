import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Define variables
  bool _isObscure = true;
  final loginEmailController = TextEditingController();
  final loginPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var iconObscure = IconButton(
      icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off, color: Colors.white,),
      onPressed: (){setState(() {_isObscure = !_isObscure;});},
    );
    var styleInput = const TextStyle(color: Colors.white);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200.0,
              child: Image.asset('resources/login.png'),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              controller: loginEmailController,
              style: styleInput,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email, color: Colors.white,),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: loginPassController,
              style: styleInput,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock, color: Colors.white,),
                suffixIcon: iconObscure,
              ),
              obscureText: _isObscure,
            ),
            const SizedBox(
              height: 24.0,
            ),
            ElevatedButton(
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
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }



}