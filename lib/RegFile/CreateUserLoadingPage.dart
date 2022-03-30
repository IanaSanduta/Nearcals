// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:nearcals/RegFile/UserCreatedPage.dart';
import 'package:nearcals/RegFile/userSetup.dart';
import 'package:nearcals/shared/HomeLoadingPage.dart';
import 'package:nearcals/shared/loading.dart';

class CreateLoadingPage extends StatefulWidget {
  const CreateLoadingPage({Key? key}) : super(key: key);
  @override
  _CreateLoadingPage createState() => _CreateLoadingPage();
}

class _CreateLoadingPage extends State<CreateLoadingPage> {
  @override
  Widget build(BuildContext context) {
    loading = true;
    // This is where the data from the server is pulled from here on in you are working with local variables.
    // However when you change a local variable with the currentUser.set....() class function it updates the server for next login.

    firebaseUserSetup(regUser.userName, regUser.userEmail, regUser.userP).then(
        (value) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const UserCreatedPage()))); // After pullUserData fully executes it redirect to the HomePage()
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.blue.shade900,
          );
  }
}
