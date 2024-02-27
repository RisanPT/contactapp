// import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Ui extends ChangeNotifier {
//   bool _isDark = false;
//   bool get isDark => _isDark;
//   late SharedPreferences storage;

//   final darkTheme = ThemeData(
//       primaryColor: Colors.black12,
//       brightness: Brightness.dark,
//       primaryColorDark: Colors.black12,
//       textTheme: TextTheme(
//           bodyLarge: TextStyle(
//         color: Colors.white,
//       )));

//   final lightTheme = ThemeData(
//       primaryColor: Colors.white,
//       brightness: Brightness.light,
//       primaryColorLight: Colors.white,
//       textTheme: TextTheme(
//           bodyLarge: TextStyle(
//         color: Colors.black,
//       )));
//   changeTheme() {
//     _isDark = !isDark;
//     storage.setBool("isDark", _isDark);
//     notifyListeners();
//   }

//   Init() async {
//     storage = await SharedPreferences.getInstance();
//     _isDark = storage.getBool("isDark") ?? false;
//     notifyListeners();
//   }
// }



import 'package:flutter/material.dart';

 var  lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  // Customize your light theme colors and styles here
);

  var darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.grey,
  // Customize your dark theme colors and styles here
);
