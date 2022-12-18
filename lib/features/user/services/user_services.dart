import 'package:flutter/cupertino.dart';
import 'package:fresp/constants/error_handling.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/constants/utils.dart';
import 'package:fresp/models/order.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:fresp/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserServices {
  Future<Order> getOrder(BuildContext context, String orderId) async {
    Order order = Order(orderId: "", totalPrice: 0);
    final userDetailProvider =
        Provider.of<UserDetailProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/v1/order/$orderId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: (() {
            order = Order.fromJson(res.body);
          }));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return (order);
  }
}
