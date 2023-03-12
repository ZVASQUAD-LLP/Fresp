import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/user/widgets/account_details.dart';
import 'package:fresp/features/user/widgets/accout_button.dart';
import 'package:fresp/features/user/widgets/below_appbar.dart';
import 'package:fresp/features/user/widgets/orders.dart';
import 'package:fresp/features/user/widgets/single_product.dart';
import 'package:fresp/features/user/widgets/top_buttons.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
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
              // Container(
              //     padding: const EdgeInsets.only(left: 15, right: 15),
              //     child: Icon(FeatherIcons.user) //TODO: change icon

              //     ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            BelowAppBar(),
            // SizedBox(
            //   height: 10,
            // ),
            // TopButtons(),
            SizedBox(
              height: 20,
            ),
            AccountDetails(),
          ],
        ),
      ),
    );
  }
}
