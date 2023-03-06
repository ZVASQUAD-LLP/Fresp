import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/cart/screen/cart_screen.dart';
import 'package:fresp/features/categories/screen/categories_screen.dart';
import 'package:fresp/features/user/screen/user_screen.dart';
import 'package:fresp/models/user.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../features/homescreen/screens/homescreen.dart';

class BottomBarScreen extends StatefulWidget {
  static const String routeName = '/home';
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedindex = 0;
  final List _pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const UserScreen(),
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  double bottomBarBorderWidth = 3.0;
  double bottomBarWidth = 40.0;
  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserDetailProvider>().user.cart.length;
    return Scaffold(
      body: _pages[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: GlobalVariables.backgroundColor,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        // selectedItemColor: GlobalVariables.selectedNavBarColor,
        // unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        currentIndex: _selectedindex,
        onTap: _selectedPage,
        iconSize: 20,
        items:
            // const <BottomNavigationBarItem>
            [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _selectedindex == 0
                            ? GlobalVariables.darkNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth)),
              ),
              padding: const EdgeInsets.only(top: 5.0),
              child: const Icon(FeatherIcons.home),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _selectedindex == 1
                            ? GlobalVariables.darkNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth)),
              ),
              child: const Icon(FeatherIcons.search),
              padding: const EdgeInsets.only(top: 5.0),
            ),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _selectedindex == 2
                            ? GlobalVariables.darkNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth)),
              ),
              child: Badge(
                  elevation: 0,
                  badgeContent: Text(userCartLen.toString()),
                  badgeColor: Colors.white,
                  child: const Icon(FeatherIcons.shoppingCart)),
              padding: const EdgeInsets.only(top: 5.0),
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _selectedindex == 3
                            ? GlobalVariables.darkNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth)),
              ),
              child: const Icon(FeatherIcons.user),
              padding: const EdgeInsets.only(top: 5.0),
            ),
            label: "User",
          ),
        ],
      ),
    );
  }
}
