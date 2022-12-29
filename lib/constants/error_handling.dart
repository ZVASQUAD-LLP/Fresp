import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fresp/constants/utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, "Error!", response.body, 0);
      break;
    case 500:
      showSnackBar(context, "Error!", response.body, 0);
      break;
    default:
      showSnackBar(context, "Error!", response.body, 0);
  }
}
