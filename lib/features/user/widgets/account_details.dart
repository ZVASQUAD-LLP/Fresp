import 'package:flutter/material.dart';
import 'package:fresp/common/widgets/custom_button.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/user/widgets/single_product.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:fresp/common/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  State<AccountDetails> createState() => _AccountDetails();
}

class _AccountDetails extends State<AccountDetails> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDetailProvider>(context).user;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                'Your Account',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Material(
                  color: GlobalVariables.secondaryColorYellow.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      // onTap: navigateToOrderScreen,
                      //  user.address.isEmpty?navigateToAddress:OrderScreen()
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextWidget(
                          text: 'Edit',
                          textSize: 16,
                          color: Colors.black,
                        ),
                      ))),
            )

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
        // Container(
        //   height: 300,
        //   padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
        //   child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: user.orderHistory.length,
        //       itemBuilder: ((context, index) {
        //         return SingleProduct(
        //             orderId: user.orderHistory[index].toString());
        //       })),
        // ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 25, right: 25, top: 20),
          tileColor: GlobalVariables.backgroundColor,
          title: Text('Name: ' + user.name, style: TextStyle(fontSize: 15)),
          //trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit))
        ),
        ListTile(
            contentPadding: EdgeInsets.only(left: 25, right: 25),
            tileColor: GlobalVariables.backgroundColor,
            title: Text('Email: ' + user.email, style: TextStyle(fontSize: 15)),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit))),
        ListTile(
            contentPadding: EdgeInsets.only(left: 25, right: 25),
            tileColor: GlobalVariables.backgroundColor,
            title:
                Text('Mobile: ' + user.number, style: TextStyle(fontSize: 15)),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit))),
      ],
    );
  }
}
