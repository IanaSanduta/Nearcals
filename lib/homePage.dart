// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nearcals/Calories.dart';
import 'package:nearcals/classes/userClass.dart';
import 'package:nearcals/shared/HomeLoadingPage.dart';
import 'package:nearcals/shared/naviDrawer.dart';
import 'package:nearcals/shared/userLang.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorOfWheel = Colors.lightBlue;
    int? curCals = currentUser.getCurrentCals();
    int? dayCals = currentUser.getDailyCals();
    if (curCals!.isNegative) {
      dayCals = curCals.abs() + dayCals!;
      curCals = 0;
    }
    int? calsLeftInt = dayCals! - curCals;
    double? calsLeftPer = 1 - (curCals / dayCals);
    String stCalsLeft = calsLeftInt.toString();
    if (dayCals < curCals) {
      calsLeftPer = 1.0;
      calsLeftInt = dayCals - curCals;
      colorOfWheel = Colors.red;
      stCalsLeft = calsLeftInt.toString();
    }
    final addCalsController = TextEditingController();
    final removeCalsController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(text('Home')),
        backgroundColor: Colors.lightBlue.shade900,
      ),
      drawer: const NaviDrawer(),
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    color: Colors.blue.shade900,
                    height: 100,
                  ),
                ),
              ),
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: Colors.blue,
                  height: 90,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
          CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 30.0,
            percent: calsLeftPer,
            animation: true,
            animationDuration: 1500,
            center: Text(stCalsLeft, style: const TextStyle(fontSize: 20)),
            footer: Text(
              text('Remaining Calories') + ': $stCalsLeft',
              style: TextStyle(
                fontSize: 20,
                color: colorOfWheel,
              ),
            ),
            progressColor: colorOfWheel,
          ),
          const Text(''),
          Text(
            text('Add Meal Calories:'),
            style: const TextStyle(color: Colors.blue),
            textScaleFactor: 1,
          ),
          TextField(
            controller: addCalsController,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.add,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(''),
          Text(
            text('Add Burnt Calories:'),
            style: const TextStyle(color: Colors.blue),
            textScaleFactor: 1,
          ),
          TextField(
            controller: removeCalsController,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.add,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              try {
                if (addCalsController.text != '' ||
                    removeCalsController.text != '') {
                  if (addCalsController.text != '') {
                    int addCals = int.parse(addCalsController.text);
                    currentUser.setCurrentCals(
                        currentUser.getCurrentCals()! + addCals);
                  }
                  if (removeCalsController.text != '') {
                    int removeCals = int.parse(removeCalsController.text);
                    currentUser.setCurrentCals(
                        currentUser.getCurrentCals()! - removeCals);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            text('Please enter a value into the text fields.')),
                        duration: const Duration(seconds: 3),
                        backgroundColor: Colors.red.shade700),
                  );
                }
              } catch (e) {
                addCalsController.clear();
                removeCalsController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(text('Please use only whole numbers.')),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.red.shade700),
                );
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeLoadingPage()));
            },
            color: Colors.lightBlue.shade500,
            child: Text(text('Apply')),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Calories()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue.shade800,
      ),
    );
  }
}

//Custom Clipper class with Path
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom
    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
