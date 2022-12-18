import 'package:flutter/material.dart';
import 'package:fresp/common/widgets/text_widget.dart';
import 'package:fresp/features/address/screen/address_screen.dart';
import 'package:fresp/features/order/screen/order_screen.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:fresp/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserDetailProvider>().user;
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as double)
        .toList();
    // void navigateToAddress() {
    //   Navigator.pushNamed(context, AddressScreen.routeName,
    //       arguments: AddressScreen);
    // }

    void navigateToOrderScreen() {
      Navigator.pushNamed(context, OrderScreen.routeName,
          arguments: OrderScreen);
    }

    String sum_round = sum.toStringAsFixed(2);
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              FittedBox(
                child: TextWidget(
                  text: 'Total: \₹$sum_round',
                  color: Colors.black,
                  textSize: 20,
                  isTitle: true,
                ),
              ),
              const Spacer(),
              Material(
                  color: Color.fromARGB(255, 7, 100, 11),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: navigateToOrderScreen,
                      //  user.address.isEmpty?navigateToAddress:OrderScreen()
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                          text: 'Order Now',
                          textSize: 20,
                          color: Colors.white,
                        ),
                      ))),
            ],
          ),
        ));
  }
}
