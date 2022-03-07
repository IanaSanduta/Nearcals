import 'package:flutter/material.dart';

class Utility {

  static void showMessage(BuildContext context,String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red.shade900),
    );
  }

  static String sentenceCase(String text){
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}