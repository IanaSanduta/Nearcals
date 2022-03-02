import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'net/userSetup.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);
  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  //Define variables
  var _isObscure = true;
  var _password1 = '';
  var _password2 = '';
  final _formKey = GlobalKey<FormState>();

  //Define Firebase variables
  final regEmailController = TextEditingController();
  final regPassController = TextEditingController();
  final regUsernameController = TextEditingController();

  //Define validation methods
  String? validateUserName(String? value) {
    if (value == null) {
      return null;
    }

    var val = value.toString().trim();
    if (val.isEmpty) {
      return "This field is required";
    } else if (val.length < 4) {
      return "Username must be at least 4 characters";
    } else if (val.length > 20) {
      return ''' Username must not be greater than
       20 characters''';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null) {
      return null;
    }

    var val = value.toString().trim();
    if (val.isEmpty) {
      return "This field is required";
    }
    if (!RegExp(r'\w+@\w+\.[a-z]{3}').hasMatch(val)) {
      return "Please enter a valid email address";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return "Passwords are required";
    }

    if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$')
        .hasMatch(value)) {
      return ''' Password must be at least 8 character, 
      and at least 1 uppercase, 1 lowercase, 
      1 number, and 1 symbol.''';
    }

    var pass1 = _password1.toString().trim();
    var pass2 = _password2.toString().trim();

    if (pass1 != pass2) {
      return "Please make sure your passwords match";
    }

    return null;
  }

  //Define authentication method
  void authSignUp() async {
    CollectionReference userProfile =
        FirebaseFirestore.instance.collection('UserProfile');

    if (_formKey.currentState!.validate()) {
      try {
        //Send the login request to the API
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: regEmailController.text.trim(),
          password: regPassController.text.trim(),
        );

        //Check if the user has logged in correctly
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          firebaseUserSetup(regUsernameController.text.trim(),
              regEmailController.text.trim(), regPassController.text.trim());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      controller: regUsernameController,
                      validator: validateUserName,
                      style: styleInput,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: regEmailController,
                      validator: validateEmail,
                      style: styleInput,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: regPassController,
                      validator: validatePassword,
                      style: styleInput,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: iconObscure,
                      ),
                      onChanged: (value) => _password1 = value,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      validator: validatePassword,
                      style: styleInput,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: iconObscure,
                      ),
                      onChanged: (value) => _password2 = value,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      onPressed: authSignUp,
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
