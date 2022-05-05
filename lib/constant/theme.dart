// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

ThemeData light = ThemeData(
  fontFamily: 'Roboto',
  brightness: Brightness.light,
  primaryColor: Color.fromARGB(255, 194, 1, 1),
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 41, 41, 41)),
    headline2: TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
    bodyText1: TextStyle(
      fontSize: 14.0,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    fixedSize: MaterialStateProperty.all(Size(250, 50)),
    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 15)),
    backgroundColor:
        MaterialStateProperty.all<Color>(Color.fromARGB(255, 212, 26, 26)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
  )),
);

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  brightness: Brightness.dark,
  primaryColor: Color.fromARGB(255, 248, 49, 34),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      fontSize: 14.0,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    fixedSize: MaterialStateProperty.all(Size(250, 50)),
    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 15)),
    backgroundColor:
        MaterialStateProperty.all<Color>(Color.fromARGB(255, 189, 2, 2)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
  )),
);

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (Get.isDarkMode) {
            Get.changeThemeMode(ThemeMode.light);
            GetStorage().write('theme', 'light');
          }

          if (Get.isDarkMode == false) {
            Get.changeThemeMode(ThemeMode.dark);
            GetStorage().write('theme', 'dark');
          }
        },
        child: const Text('themee'));
  }
}

// ignore: non_constant_identifier_names
void LoadTheme() {
  var theme = GetStorage().read('theme');
  if (theme == 'dark') {
    Get.changeThemeMode(ThemeMode.dark);
  } else {
    Get.changeThemeMode(ThemeMode.light);
  }
}
