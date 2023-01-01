import 'package:flutter/material.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/user/widgets/single_product.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDetailProvider>(context).user;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.only(right: 15),
            //   child: Text(
            //     'See all',
            //     style: TextStyle(
            //       fontSize: 15,
            //       color: GlobalVariables.secondaryColor,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: user.orderHistory.length,
              itemBuilder: ((context, index) {
                return SingleProduct(
                    orderId: user.orderHistory[index].toString());
              })),
        ),
      ],
    );
  }
}
