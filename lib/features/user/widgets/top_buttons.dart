import 'package:flutter/material.dart';
import 'package:fresp/features/auth/services/auth_service.dart';
import 'package:fresp/features/user/widgets/accout_button.dart';
import 'package:fresp/features/user/widgets/orders.dart';
import 'package:fresp/features/user/widgets/account_details.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void logOut() {
      authService.logOutUser(context);
    }

    void myOrders() async {
      const Orders();
    }

    void myAccount() async {
      const AccountDetails();
    }

    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'My Account', onTap: myAccount),
            AccountButton(text: 'Orders', onTap: myOrders),
            AccountButton(text: 'Log Out', onTap: logOut),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
