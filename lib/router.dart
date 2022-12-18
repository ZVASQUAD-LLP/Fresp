import 'package:flutter/material.dart';
import 'package:fresp/features/address/screen/address_screen.dart';
import 'package:fresp/features/admin/screens/add_product_screen.dart';
import 'package:fresp/features/auth/screens/auth_screen.dart';
import 'package:fresp/common/widgets/bottom_bar.dart';
import 'package:fresp/features/cart/screen/cart_screen.dart';
import 'package:fresp/features/cart/screen/empty_screen.dart';
import 'package:fresp/features/order/screen/order_screen.dart';
import 'package:fresp/features/product/screen/product_details.dart';
import 'package:fresp/features/searched%20screen/screens/searched_screen.dart';
import 'package:fresp/features/testscreen.dart';
import 'package:fresp/models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case AddressScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const AddressScreen());
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );
    case ProductDetails.routename:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetails(product: product),
      );
    case EmptyCartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EmptyCartScreen(),
      );

    case TestScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TestScreen(),
      );
    case BottomBarScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBarScreen(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case SearchedScreen.routename:
      var categoryId = routeSettings.arguments as String?;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchedScreen(category: categoryId),
      );
    case OrderScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen doesn not exist'),
          ),
        ),
      );
  }
}
