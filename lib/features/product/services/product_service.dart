import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fresp/constants/error_handling.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/constants/utils.dart';
import 'package:fresp/models/product.dart';
import 'package:fresp/models/user.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:fresp/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductService {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userDetailProvider =
        Provider.of<UserDetailProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/user/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id!, 'quantity': 1}),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userDetailProvider.user
              .copyWith(cart: jsonDecode(res.body)['cart']);
          userDetailProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> getProducts(
      BuildContext context, String category) async {
    List<Product> productList = [];
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response ProductRes = await http.get(
        Uri.parse('$uri/api/v1/product/getProduct?category=$category'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=utf-8',
          'x-auth-token': userProvider.user.token
        },
      );

      httpErrorHandle(
          response: ProductRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(ProductRes.body).length; i++) {
              productList.add(
                  Product.fromJson(jsonEncode(jsonDecode(ProductRes.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> getProduct(BuildContext context, String id) async {
    Product product = Product(
        name: '',
        description: '',
        images: [],
        brand: '',
        price: 0,
        countInStock: 0);
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response ProductRes = await http.get(
        Uri.parse('$uri/api/v1/product/$id'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=utf-8',
          'x-auth-token': userProvider.user.token
        },
      );

      httpErrorHandle(
          response: ProductRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(ProductRes.body).length; i++) {
              product =
                  Product.fromJson(jsonEncode(jsonDecode(ProductRes.body)[i]));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
