import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

void showSnackBar(BuildContext context, String text, String msg, cat) {
  /// set category of the message
  var colors = [
    GlobalVariables.secondaryColorRed,
    Color.fromARGB(255, 57, 108, 3)
  ];
  var bg_color;
  switch (cat) {
    case 0:
      cat = ContentType.failure;
      bg_color = colors[0] as Color;
      break;
    case 1:
      cat = ContentType.success;
      bg_color = colors[1] as Color;
      break;
    case 2:
      cat = ContentType.warning;
      break;
    default:
      cat = ContentType.help;
      break;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: text,
        message: msg,
        color: bg_color,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: cat,
      ),
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
