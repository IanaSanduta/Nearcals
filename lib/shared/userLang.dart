// ignore_for_file: file_names

import 'package:nearcals/classes/userClass.dart';

String text(String word) {
  String result = '';
  final List langList = ['English', 'Spanish'];
  final Map<String, Map<String, String>> langLib = {
    langList[0]: {
      'Home': 'Home',
      'Profile': 'Profile',
      'Map': 'Map',
      'Calories': 'Calories',
      'Favorites': 'Favorites',
      'Settings': 'Settings',
      'Guide': 'Guide',
      'Logout': 'Logout',
      'Email': 'Email',
      'Username': 'Username',
      'Daily Calories': 'Daily Calories',
      'Save': 'Save',
      'Foodie Map': 'Foodie Map',
      'Sign Up': 'Sign Up',
      'Login': 'Login'
    },
    langList[1]: {
      'Home': '.',
      'Profile': '.',
      'Map': '.',
      'Calories': '.',
      'Favorites': '.',
      'Settings': '.',
      'Guide': '.',
      'Logout': '.',
      'Email': '.',
      'Username': '.',
      'Daily Calories': '.',
      'Save': '.',
      'Foodie Map': '.',
      'Sign Up': '.',
      'Login': '.'
    },
    //Do Not delet rows below its used as a guide to add more languages.
    /*
    langList[.]: {
      'Home': '.',
      'Profile': '.',
      'Map': '.',
      'Calories': '.',
      'Favorites': '.',
      'Settings': '.',
      'Guide': '.',
      'Logout': '.',
      'Email': '.',
      'Username': '.',
      'Daily Calories':'.',
      'Save':'.',
      'Foodie Map': '.',
      'Sign Up':'.',
      'Login': '.'
    }*/
  };
  Map<String, String>? languageLibrary = langLib[currentUser.getUserLang()];
  result = languageLibrary![word] as String;
  return result;
}
