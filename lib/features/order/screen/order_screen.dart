import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/address/screen/address_screen.dart';
import 'package:fresp/features/order/widgets/orders_widget.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '/order-screen';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDetailProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: Icon(FeatherIcons.arrowLeft),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/amazon_in.png',
                    width: 120, height: 45, color: Colors.black),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Icon(FeatherIcons.user) //TODO: change icon

                  ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: user.address.isEmpty
              ? AddressScreen()
              : Container(
                  height: 470,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OrdersWidget(),
                  ))),
    );
  }
}
