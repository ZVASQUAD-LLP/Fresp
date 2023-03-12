// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fresp/features/user/services/user_services.dart';
import 'package:fresp/models/order.dart';

class SingleProduct extends StatefulWidget {
  final String orderId;
  const SingleProduct({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  final UserServices userServices = UserServices();
  Order order = Order(orderId: "", totalPrice: 0);

  void getOrder() async {
    var orderRes = await userServices.getOrder(context, widget.orderId);
    setState(() {
      order = orderRes;
    });
  }

  @override
  void initState() {
    super.initState();
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 1.3),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: Container(
            width: 150,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.orderId),
                Text((order.totalPrice).toStringAsFixed(2))
              ],
            )),
      ),
    );
  }
}
