import 'package:flutter/material.dart';
import 'package:fresp/common/widgets/custom_button.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/auth/services/auth_service.dart';
import 'package:fresp/features/address/screen/add_address_screen.dart';
import 'package:fresp/features/user/widgets/single_address.dart';
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
  final AuthService authService = AuthService();
  void navigateToAddressScreen() {
    Navigator.pushNamed(context, AddAddressScreen.routeName,
        arguments: AddAddressScreen);
  }

  void logOut() {
    authService.logOutUser(context);
  }

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
                  color: GlobalVariables.selectedNavBarColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: logOut,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextWidget(
                          text: 'Log Out',
                          textSize: 16,
                          color: Colors.black,
                        ),
                      ))),
            ),
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
        Center(
          child: Card(
            margin: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black38),
                borderRadius: BorderRadius.circular(10)),
            shadowColor: Colors.black87,
            elevation: 5,
            surfaceTintColor: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.only(left: 25, right: 25, top: 10),
                  tileColor: GlobalVariables.backgroundColor,
                  title: Text('Name: ' + user.name,
                      style: TextStyle(fontSize: 15)),
                  //trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                ),
                ListTile(
                    contentPadding: EdgeInsets.only(left: 25, right: 25),
                    tileColor: GlobalVariables.backgroundColor,
                    title: Text('Email: ' + user.email,
                        style: TextStyle(fontSize: 15))),
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                        contentPadding: EdgeInsets.only(left: 25, right: 25),
                        tileColor: GlobalVariables.backgroundColor,
                        title: Text('Mobile: +91-' + user.number,
                            style: TextStyle(fontSize: 15)))),
              ],
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: const Text(
              'Your Addresses',
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
                color: GlobalVariables.selectedNavBarColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: navigateToAddressScreen,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: TextWidget(
                        text: 'Add new',
                        textSize: 16,
                        color: Colors.black,
                      ),
                    ))),
          ),
        ]),
        Container(
            height: 230,
            padding: const EdgeInsets.only(left: 10, top: 10, right: 0),
            child: SingleAddress()),
      ],
    );
  }
}
