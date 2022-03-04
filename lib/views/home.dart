// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nearcals/views/welcomePage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) => WelcomePage()
        ));
      },),*/
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('NearCals'),
          ],
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 186),
                child: Icon(
                  Icons.fastfood,
                  color: Colors.blue,
                  size: 200.0,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomePage()),
                  );
                },
                child: const Text('Explore'),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
