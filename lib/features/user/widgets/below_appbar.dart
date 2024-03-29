import 'package:flutter/material.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_detail_provider.dart';
import '../../../providers/user_provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDetailProvider>(context).user;

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: RichText(
          text: TextSpan(
              text: 'Hello, ',
              style: TextStyle(
                fontFamily: 'AmazonEmber',
                fontSize: 20,
                color: Colors.black,
              ),
              children: [
            TextSpan(
              text: user.name,
              style: TextStyle(
                  fontFamily: 'AmazonEmber',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            )
          ])),
    );
  }
}
