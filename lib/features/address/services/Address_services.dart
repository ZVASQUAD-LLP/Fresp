import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fresp/constants/error_handling.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/constants/utils.dart';
import 'package:fresp/models/address.dart';
import 'package:fresp/models/user.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:fresp/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddressServices {
  Future<List<Address>> getAddress(BuildContext context) async {
    List<Address> address = [];
    final userDetailProvider =
        Provider.of<UserDetailProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/v1/user/address/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              address
                  .add(Address.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return (address);
  }

  void addAddress(BuildContext context,
      {required String street,
      required String apartment,
      required String zip,
      required String city,
      String? id}) async {
    final userDetailProvider =
        Provider.of<UserDetailProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Address address = Address(street, apartment, zip, city, id);
    http.Response res = await http.post(Uri.parse('$uri/api/v1/user/address'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=utf-8',
          'x-auth-token': userProvider.user.token
        },
        body: address.toJson());
    httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userDetailProvider.user
              .copyWith(address: jsonDecode(res.body)['address']);
          userDetailProvider.setUserFromModel(user);
        });
  }
}
