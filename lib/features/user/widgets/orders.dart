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
    return Card(
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.black87,
      elevation: 5,
      surfaceTintColor: Colors.black,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: user.orderHistory.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text('${user.orderHistory[index].toString()}'),
              );
              // return SingleProduct(
              //     orderId: user.orderHistory[index].toString());
            })),
      ),
    );
  }
}
