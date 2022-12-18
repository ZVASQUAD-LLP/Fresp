// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:fresp/common/widgets/utils.dart';
import 'package:fresp/features/cart/screen/cart_screen.dart';
import 'package:fresp/features/product/services/product_service.dart';
import 'package:fresp/models/product.dart';

import '../../features/product/screen/product_details.dart';
import 'price_widget.dart';
import 'text_widget.dart';

class SaleWidgetAdmin extends StatefulWidget {
  const SaleWidgetAdmin({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  @override
  State<SaleWidgetAdmin> createState() =>
      _SaleWidgetAdminState(product: this.product);
}

class _SaleWidgetAdminState extends State<SaleWidgetAdmin> {
  final ProductService productService = ProductService();
  void addToCart() {
    productService.addToCart(context: context, product: widget.product);
  }

  Product? product;
  _SaleWidgetAdminState({required this.product});
  void navigateToCart() {
    Navigator.pushNamed(context, CartScreen.routeName, arguments: CartScreen);
  }

  void navigateToProduct(String? query) {
    Navigator.pushNamed(context, ProductDetails.routename, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreenSize;

    return GestureDetector(
        onTap: () {
          navigateToProduct(product?.id);
        },
        child: Container(
            margin: const EdgeInsets.all(5),
            child: Material(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromARGB(255, 245, 244, 244),
              child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    navigateToProduct(product?.id);
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x54000000),
                                      spreadRadius: 10,
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  product!.images[0],
                                  width: size.width * 0.30,
                                  height: size.width * 0.18,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: 100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: product?.name,
                                            color: color,
                                            textSize: 15,
                                            isTitle: true,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          PriceWidget(price: product?.price),
                                          const SizedBox(height: 0.1),
                                          // TextWidget(
                                          //     text: '1kg',
                                          //     color: color,
                                          //     textSize: 14,
                                          //     isTitle: true),
                                          const SizedBox(height: 0.1),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: InkWell(
                                          onTap: addToCart,
                                          child:
                                              Icon(FeatherIcons.shoppingBag)),
                                    )
                                  ]),
                            )
                          ]))),
            )));
  }
}
