// ignore_for_file: file_names

import 'package:nearcals/classes/userClass.dart';

final List langList = ['English', 'Español', 'Japanese 日本語'];
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
      'User Setup': 'User Setup',
      'Add Meal Calories:': 'Add Meal Calories:',
      'Add Burnt Calories:': 'Add Burnt Calories:',
      'Please use only whole numbers.': 'Please use only whole numbers.',
      'Please enter a value into the text fields.':
          'Please enter a value into the text fields.',
      'No Values Changed!': 'No Values Changed!',
    };
  }

  // Spanish / Español
  // I used Google Translate for this:
  // Someone who actually knows Spanish should proabably fill this out ;^)
  if (langList[1] == currentUser.getUserLang()) {
    languageLibrary = {
      'Home': 'Inicio',
      'Profile': 'Perfil',
      'Map': 'Mapas',
      'Calories': 'Calorias',
      'Favorites': 'Favoritos',
      'Settings': 'Ajustes',
      'Guide': 'Guias',
      'Logout': 'Cerrar Sesion',
      'Email': 'Correo Electronico',
      'Username': 'Nombre de Usuario',
      'Daily Calories': 'Calorias Diarias',
      'Save': 'Guardar',
      'Foodie Map': 'Mapa de Restaurantes',
      'Sign Up': 'Registrar',
      'Login': 'Iniciar Sesion',
      'Language': 'Idioma',
      'General': 'General',
      'GENERAL': 'GENERAL',
      'Apply': 'Aplicar',
      'Update Successful': 'Actualización Completa',
      'Apply Settings': 'Aplicar Ajustes',
      'Remaining Calories': 'Calorias Totales',
      'Enter your email': 'Ingrese correo electronico',
      'Enter your password': 'Ingrese su contrasena',
      'Camera': 'Camara',
      'Gallery': 'Galeria',
      'Profile Photo': 'Foto de Perfil',
      'Select Language': 'Seleccionar idioma',
      'User Setup': 'Configuración de usuario',
      'Add Meal Calories:': 'Agregue calorías de la comida:',
      'Add Burnt Calories:': 'Añadir calorías quemadas:',
      'Please use only whole numbers.':
          'Por favor, utilice sólo números enteros.',
      'Please enter a value into the text fields.':
          'Introduzca un valor en los campos de texto.',
      'No Values Changed!': '¡No hay valores cambiados!',
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
      'User Setup': 'ユーザー設定',
      'Add Meal Calories:': '食事カロリーを追加:',
      'Add Burnt Calories:': '燃焼カロリーを追加:',
      'Please use only whole numbers.': '整数のみを使用してください。',
      'Please enter a value into the text fields.': 'テキストフィールドに値を入力してください。',
      'No Values Changed!': '値は変更されません!',
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
      'User Setup':'.',
      'Add Meal Calories:': '.',
      'Add Burnt Calories:': '.',
      'Please use only whole numbers.': '.',
      'Please enter a value into text field.' :'.',
      'No Update Made':'.',
      
      
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
