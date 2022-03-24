// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nearcals/classes/userClass.dart';
import 'package:nearcals/homePage.dart';
import 'package:nearcals/shared/loading.dart';

bool loading = false;

class HomeLoadingPage extends StatefulWidget {
  const HomeLoadingPage({Key? key}) : super(key: key);
  @override
  _HomeLoadingPage createState() => _HomeLoadingPage();
}

class _HomeLoadingPage extends State<HomeLoadingPage> {
  @override
  Widget build(BuildContext context) {
    loading = true;
    // This is where the data from the server is pulled from here on in you are working with local variables.
    // However when you change a local variable with the currentUser.set....() class function it updates the server for next login.
    pullUserData().then((value) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const HomePage()))); // After pullUserData fully executes it redirect to the HomePage()
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.blue.shade900,
          );
  }
}
