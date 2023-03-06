import 'package:flutter/material.dart';

String uri = 'http://192.168.42.201:4000';
// String uri = 'https://intense-brook-05872.herokuapp.com';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 196, 255, 97),
      Color.fromARGB(255, 215, 255, 148),
    ],
    stops: [0.5, 1.0],
  );

  // static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  // static const googleColor = Color.fromARGB(255, 195, 195, 195);
  // static const backgroundColor = Colors.white;
  // static const greyBackgroundCOlor = Color.fromARGB(245, 245, 246, 245);
  // static var selectedNavBarColor = const Color.fromARGB(255, 99, 209, 219);
  // static const unselectedNavBarColor = Colors.black87;

  static const secondaryColor = Color.fromARGB(255, 255, 139, 0);
  static const darkNavBarColor = Color.fromARGB(255, 57, 108, 3);
  static const backgroundColor = Color.fromARGB(255, 255, 255, 255);
  static const greyBackgroundCOlor = Color.fromARGB(255, 234, 255, 199);
  static var selectedNavBarColor = const Color.fromARGB(255, 196, 255, 97);
  static const unselectedNavBarColor = Color.fromARGB(255, 26, 26, 26);
  static const secondaryColorYellow = Color.fromARGB(255, 255, 217, 0);
  static const secondaryColorRed = Color.fromARGB(255, 255, 74, 1);
}
