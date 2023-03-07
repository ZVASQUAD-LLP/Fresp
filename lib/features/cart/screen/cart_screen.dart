import 'package:flutter/material.dart';
import 'package:fresp/common/widgets/utils.dart';
import 'package:fresp/features/cart/screen/empty_screen.dart';
import 'package:fresp/features/cart/widgets/cart_subtotal.dart';
import 'package:fresp/features/cart/widgets/cart_widget.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToEmptyScreen() {
    Navigator.pushNamed(context, EmptyCartScreen.routeName,
        arguments: EmptyCartScreen);
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final user = Provider.of<UserDetailProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/logo_transperant.png',
                    width: 150, height: 100, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 450,
          child: Column(
            children: [
              CartSubtotal(),
              Expanded(
                child: ListView.builder(
                  itemCount: user.cart.length,
                  itemBuilder: (context, index) {
                    return CartWidget(index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
