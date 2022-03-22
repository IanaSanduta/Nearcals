
import 'package:flutter/material.dart';
import 'package:nearcals/classes/userClass.dart';
import 'package:nearcals/shared/loading.dart';
import '../Calories.dart';
import 'package:nearcals/models/food.api.dart';


bool loading = false;

class CalorieLoadingPage extends StatefulWidget {
  const CalorieLoadingPage({Key? key}) : super(key: key);
  @override
  _CalorieLoadingPage createState() => _CalorieLoadingPage();
}

class _CalorieLoadingPage extends State<CalorieLoadingPage> {
  @override
  Widget build(BuildContext context) {
    loading = true;
    // This is where the data from the server is pulled from here on in you are working with local variables.
    // However when you change a local variable with the currentUser.set....() class function it updates the server for next login

    FoodApi.getcalories().then((value) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
            const Calories()))); // After pullUserData fully executes it redirect to the HomePage()
    return loading
        ? const Loading()
        : Scaffold(
      backgroundColor: Colors.blue.shade900,
    );
  }
}
