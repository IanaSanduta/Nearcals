import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nearcals/net/userData.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Define variables
  bool _isObscure = true;
  final loginEmailController = TextEditingController()..text = "admin@gmail.com";
  final loginPassController = TextEditingController()..text = "123456";

  //Define authentication function
  void authLongIn() async {
    try {
      //Send the login request to the API
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmailController.text.trim(),
        password: loginPassController.text.trim(),
      );


      //Check if the user has logged in correctly
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        setState(() {});

      }
    } on FirebaseAuthException catch (error) {
      //Shows a message in case of error.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(error.message!),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red.shade900),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //Define Widget variables
    var iconObscure = IconButton(
      icon: Icon(
        _isObscure ? Icons.visibility : Icons.visibility_off,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
          _isObscure = !_isObscure;
        });
      },
    );
    var styleInput = const TextStyle(color: Colors.white);

    //Start of the UI
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.blue.shade900,
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
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
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
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  suffixIcon: iconObscure,
                ),
                obscureText: _isObscure,
              ),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                onPressed: authLongIn,
                child: const Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
