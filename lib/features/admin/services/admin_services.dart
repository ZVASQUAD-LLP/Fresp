import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:fresp/constants/error_handling.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/models/category.dart';
import 'package:fresp/models/product.dart';
import 'package:fresp/providers/user_provider.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:fresp/constants/utils.dart';
import 'package:provider/provider.dart';

class AdminServices {
  void SellProduct({
    required BuildContext context,
    required String name,
    required String brand,
    required String description,
    required double price,
    required int quantity,
    required String? category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("djxqhygru", "rswouelh");
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          images: imageUrls,
          brand: brand,
          price: price,
          category: category!,
          countInStock: quantity);
      http.Response postRes =
          await http.post(Uri.parse('$uri/api/v1/product/admin/add-product'),
              headers: <String, String>{
                'Content-type': 'application/json; charset=utf-8',
                'x-auth-token': userProvider.user.token
              },
              body: product.toJson());
      print(postRes);
      httpErrorHandle(
          response: postRes,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product posted!');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<CategoryList>> getCategories(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<CategoryList> categoryList = [];
    try {
      http.Response categoryRes = await http
          .get(Uri.parse('$uri/api/v1/category/'), headers: <String, String>{
        'Content-type': 'application/json; charset=utf-8',
        'x-auth-token': userProvider.user.token
      });

      httpErrorHandle(
          response: categoryRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(categoryRes.body).length; i++) {
              categoryList.add(CategoryList.fromJson(
                  jsonEncode(jsonDecode(categoryRes.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return categoryList;
  }
}
