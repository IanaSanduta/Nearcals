import 'package:flutter/material.dart';
import 'classes/dataBase.dart';
import 'classes/userClass.dart';
import 'classes/utility.dart';
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
  final loginPassController = TextEditingController()..text = "passWord1";

  //Define Authentication method
  void authLongIn() {
      DataBase db = DataBase();
      var credential = db.longIn(loginEmailController.text, loginPassController.text);

      //Login to firebase
      credential.then((login){
          //Check if the user has logged in correctly
          if(login != null) {
              db.getCollection('UserData').then((data) {
                //Create User Object and add data
                UserProfile user = UserProfile();
                user.setUserName(data[dbUser.name.text]);
                user.setEmail(data[dbUser.email.text]);
                user.setUserImage(data[dbUser.image.text]);
                user.setCurrentCals(data[dbUser.currentCal.text]);
                user.setDailyCals(data[dbUser.dailyCal.text]);

                //Redirection to the next page
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(account: user)));
              });
          }
      });

      //Handle firebase exceptions
      credential.catchError((error){
        Utility.showMessage(context, error.message);
      });
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
