import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils{
  BuildContext context;
  Utils(this.context);

  Size get getscreenSize => MediaQuery.of(context).size;
  Color get color => Colors.black;
}