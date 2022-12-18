// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fresp/models/product.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:provider/provider.dart';

class CustomTextWidget extends StatelessWidget {
  final int index;
  const CustomTextWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserDetailProvider>().user.cart[index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return Center(
      child: Text(
        '${product.name} x ${quantity}',
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
