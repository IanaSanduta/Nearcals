import 'package:flutter/material.dart';
import 'package:nearcals/classes/utility.dart';
import 'classes/dataBase.dart';
import 'classes/userClass.dart';
import 'home_page.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);
  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  //Define variables
  var _isObscure = true;
  var _password = '';
  var _confirmPassword = '';
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
    } else if (val.length < 3) {
      return "Username must be at least 3 characters";
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
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,20}$')
        .hasMatch(value)) {
      return ''' Password must be at least 8 character, 
      and at least 1 uppercase, 1 lowercase, 
      1 number, and 1 symbol.''';
    }

    var pass1 = _password.toString().trim();
    var pass2 = _confirmPassword.toString().trim();

    if (pass1 != pass2) {
      return "Please make sure your passwords match";
    }

    return null;
  }

  //Define authentication method
  void authSignUp()  {
    if (_formKey.currentState!.validate()) {
        DataBase db = DataBase();
        var credential = db.createUser(regEmailController.text.trim(), regPassController.text.trim());

        //Create new user on Firebase
        credential.then((createUser) {
            // Check if the user has been created
            if (createUser != null) {
              //Set variable map
              var userData = {
                dbUser.name.text: regUsernameController.text.trim(),
                dbUser.email.text: regEmailController.text.trim(),
                dbUser.image.text: 'Image',
                dbUser.dailyCal.text: 2000,
                dbUser.currentCal.text: 2000,
              };

              //Add data to UserData collection
              db.setCollection('UserData', userData);
              var user = UserProfile.useMap(userData);

              //Redirection to the next page
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(account: user)));
            }
        });

        //Handle firebase exceptions
        credential.catchError((error){
            Utility.showMessage(context, error.message);
        });
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
                      onChanged: (value) => _password = value,
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
                      onChanged: (value) => _confirmPassword = value,
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
