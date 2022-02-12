import 'package:flutter/material.dart';
import 'package:nearcals/login.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'NearCals',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child: MaterialButton(
                          onPressed: () {
                            //TODO:Implement login functionality.
                            },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text('Register',style: TextStyle(fontSize: 20, color: Colors.blue)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child: MaterialButton(
                          onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text('Log In',style: TextStyle(fontSize: 20, color: Colors.blue)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}