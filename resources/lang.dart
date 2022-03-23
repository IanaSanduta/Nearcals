import 'package:flutter/material.dart';
import 'package:nearcals/classes/userClass.dart';

import '';

Text text(String word) {
  String result = '';
  Map<String, Map<String, String>> langLib = {
    'English': {
      'Home': 'Home',
      'Profile': 'Profile',
      'Map': 'Map',
      'Calories': 'Calories',
      'Favorites': 'Favorites',
      'Settings': 'Settings',
      'Guide': 'Guide'
    },
    'Spanish': {
      'Home': '.',
      'Profile': '.',
      'Map': '.',
      'Calories': '.',
      'Favorites': '.',
      'Settings': '.',
      'Guide': '.'
    },
  };
  result = langLib.containsKey(currentUser.getUserLang()).containsValue();
  return Text(result);
}
