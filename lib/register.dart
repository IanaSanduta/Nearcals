import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

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
  final  _formKey = GlobalKey<FormState>();

  //Define Firebase variables
  final regEmailController = TextEditingController();
  final regPassController = TextEditingController();

  //Define validation methods
  String? validateUserName(String? value) {
    if(value == null) {
      return null;
    }

    var val = value.toString().trim();
    if(val.isEmpty) {
      return "This field is required";
    }else if (val.length < 6) {
      return "Username must be at least 4 characters";
    } else if (val.length > 20) {
      return "Username must not be greater than 20 characters";
    }

    return null;
  }

  String? validateEmail(String? value) {
    if(value == null) {
      return null;
    }

    var val = value.toString().trim();
    if(val.isEmpty) {
      return "This field is required";
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
      return "Please enter a valid email address";
    }

    return null;
  }

  String? validatePassword(String? value) {

    var pass1 = _password1.toString().trim();
    var pass2 = _password2.toString().trim();

    if(pass1.isEmpty || pass2.isEmpty) {
      return "Passwords are required";
    }else if (pass1.length < 8 || pass1.length < 8) {
      return "Passwords should be at least 8 characters";
    } else if (pass1.length > 20 || pass1.length > 20) {
      return "Passwords should not be greater than 20 characters";
    }
    if(pass1 != pass2) {
      return "Please make sure your passwords match";
    }

    return null;
  }

  //Define authentication method
  void authSignUp() async
  {
      if (_formKey.currentState!.validate()) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: regEmailController.text.trim(),
          password: regPassController.text.trim(),
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
      }
  }

  @override
  Widget build(BuildContext context) {

    var iconObscure = IconButton(
      icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off, color: Colors.white,),
      onPressed: (){setState(() {_isObscure = !_isObscure;});},
    );
    var styleInput = const TextStyle(color: Colors.white);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.headline2,),
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  validator: validateUserName,
                  style: styleInput,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.account_circle, color: Colors.white,),
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
                    prefixIcon: Icon(Icons.email, color: Colors.white,),
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
                    prefixIcon: const Icon(Icons.lock, color: Colors.white,),
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
                    prefixIcon: const Icon(Icons.lock, color: Colors.white,),
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
    );

  }
}
