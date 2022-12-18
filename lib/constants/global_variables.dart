import 'package:flutter/material.dart';

String uri = 'http://192.168.42.102:4000';
//String uri = 'https://intense-brook-05872.herokuapp.com';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const googleColor = Color.fromARGB(255, 195, 195, 195);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color.fromARGB(255, 99, 209, 219);
  static const unselectedNavBarColor = Colors.black87;
}
