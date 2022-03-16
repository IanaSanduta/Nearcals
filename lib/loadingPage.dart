// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nearcals/classes/userClass.dart';
import 'package:nearcals/shared/loading.dart';
import 'home_page.dart';

bool loading = false;

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);
  @override
  _LoadingPage createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    loading = true;
    pullUserData().then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage())));
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.blue.shade900,
          );
  }
}
