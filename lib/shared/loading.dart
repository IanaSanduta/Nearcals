import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue.shade900,
        child: const Center(
            child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
          duration: Duration(seconds: 1),
        )));
  }
}
