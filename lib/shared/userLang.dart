// ignore_for_file: file_names

import 'package:nearcals/classes/userClass.dart';

final List langList = ['English', 'Español', 'Japanese 日本'];
String text(String word) {
  String result = '';
  Map<String, String>? languageLibrary;
  // English
  if (langList[0] == currentUser.getUserLang()) {
    languageLibrary = {
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
      'Login': 'Login',
      'Language': 'Language',
      'General': 'General',
      'GENERAL': 'GENERAL',
      'Apply': 'Apply',
      'Update Successful': 'Update Successful',
      'Apply Settings': 'Apply Settings',
      'Remaining Calories': 'Remaining Calories',
      'Enter your email': 'Enter your email',
      'Enter your password': 'Enter your password',
      'Camera': 'Camera',
      'Gallery': 'Gallery',
      'Profile Photo': 'Profile Photo',
      'Select Language': 'Select Language',
      'User Setup': 'User Setup'
    };
  }

  // Spanish / Español
  // I used Google Translate for this:
  // Someone who actually knows Spanish should proabably fill this out ;^)
  if (langList[1] == currentUser.getUserLang()) {
    languageLibrary = {
      'Home': 'Hogar',
      'Profile': '.',
      'Map': '.',
      'Calories': '.',
      'Favorites': '.',
      'Settings': 'Configuración',
      'Guide': '.',
      'Logout': '.',
      'Email': '.',
      'Username': '.',
      'Daily Calories': '.',
      'Save': '.',
      'Foodie Map': '.',
      'Sign Up': '.',
      'Login': '.',
      'Language': 'Idioma',
      'General': '.',
      'GENERAL': '.',
      'Apply': 'Aplicar',
      'Update Successful': 'Actualización correcta',
      'Apply Settings': '.',
      'Remaining Calories': '.',
      'Enter your email': '.',
      'Enter your password': '.',
      'Camera': '.',
      'Gallery': '.',
      'Profile Photo': '.',
      'Select Language': '.',
      'User Setup': '.'
    };
  }

  // Japanese / 日本
  // I used Google translate for this too:
  // But as I was going through it I recognized some words so its atleast semi-accurate
  if (langList[2] == currentUser.getUserLang()) {
    languageLibrary = {
      'Home': '家',
      'Profile': 'プロフィール',
      'Map': '地図',
      'Calories': 'カロリー',
      'Favorites': 'お気に入り',
      'Settings': '設定',
      'Guide': 'ユーザーガイド',
      'Logout': 'ログアウト',
      'Email': '電子メールアドレス',
      'Username': 'ユーザー名',
      'Daily Calories': '毎日のカロリー',
      'Save': '保存',
      'Foodie Map': 'フードマップ',
      'Sign Up': 'サインアップ',
      'Login': 'ログイン',
      'Language': '言語',
      'General': '一般設定',
      'GENERAL': '一般設定',
      'Apply': '今すぐ申し込む',
      'Update Successful': '更新に成功',
      'Apply Settings': '設定を適用する',
      'Remaining Calories': '残りのカロリー',
      'Enter your email': 'メールアドレスを入力',
      'Enter your password': 'パスワードを入力してください',
      'Camera': 'カメラ',
      'Gallery': 'フォトギャラリー',
      'Profile Photo': 'プロフィールの写真',
      'Select Language': '言語を選択する',
      'User Setup': 'ユーザー設定'
    };
  }

  // Do Not delete rows below its used as a guide to add more languages.
  /*
    if (langList[.]==currentUser.getUserLang()) {
      languageLibrary ={
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
      'Login': '.',
      'Language':'.',
      'General':'.',
      'GENERAL':'.',
      'Apply':'.',
      'Update Successful':'.',
      'Apply Settings': '.',
      'Total Calories': '.',
      'Enter your email': '.',
      'Enter your password': '.',
      'Camera': '.',
      'Gallery': '.',
      'Profile Photo': '.',
      'Select Language': '.',
      'User Setup':'.'
    };}*/
  else {
    //this will probably never run
    result = 'Language not in Library';
  }
  try {
    result = languageLibrary![word] as String;
    if (result == '.') {
      result = 'Word is not in Library';
    }
  } catch (e) {
    result = 'Word is not in Library';
  }
  return result;
}
