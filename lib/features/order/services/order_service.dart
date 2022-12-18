import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fresp/constants/error_handling.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/constants/utils.dart';
import 'package:fresp/features/auth/services/auth_service.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:fresp/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class OrderServices {
  Future<String> createOrder(BuildContext context, String address) async {
    String res = "not yet";
    try {
      AuthService authService = AuthService();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userDetailProvider =
          Provider.of<UserDetailProvider>(context, listen: false);
      print(userDetailProvider.user.cart);
      http.Response response = await http.post(Uri.parse('$uri/api/v1/order/'),
          headers: <String, String>{
            'Content-type': 'application/json; charset=utf-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            "orderItems": userDetailProvider.user.cart,
            "addressId": address,
            "phone": userDetailProvider.user.number,
            "user": userDetailProvider.user.id
          }));
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: (() {
            print("order ID");
            print(response.body);
            res = response.body;
            authService.getUserData(context);
          }));
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    print(res);
    return (res);
  }
}
