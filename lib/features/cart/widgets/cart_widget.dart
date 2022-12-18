// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:fresp/common/widgets/text_widget.dart';
import 'package:fresp/common/widgets/utils.dart';
import 'package:fresp/features/cart/services/cart_services.dart';
import 'package:fresp/features/product/screen/product_details.dart';
import 'package:fresp/features/product/services/product_service.dart';
import 'package:fresp/models/product.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:provider/provider.dart';

//import 'package:fresp/router.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    //final Color color =Utils(context).color;
    final productCart =
        context.watch<UserDetailProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    final ProductService productDetailsServices = ProductService();
    final CartServices cartServices = CartServices();
    void increaseQuantity(Product product) {
      productDetailsServices.addToCart(
        context: context,
        product: product,
      );
    }

    void decreaseQuantity(Product product) {
      cartServices.removeFromCart(
        context: context,
        product: product,
      );
    }

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routename);
        },
        child: Container(
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              product.images[0],
                              width: 200,
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: product.name,
                                color: Colors.black,
                                textSize: 20,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                  width: 150,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () => decreaseQuantity(product),
                                        child: Container(
                                          width: 35,
                                          height: 32,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            FeatherIcons.minus,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 1.5),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        child: Container(
                                          width: 35,
                                          height: 32,
                                          alignment: Alignment.center,
                                          child: Text(
                                            quantity.toString(),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => increaseQuantity(product),
                                        child: Container(
                                          width: 35,
                                          height: 32,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            FeatherIcons.plus,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    CupertinoIcons.cart_badge_minus,
                                    color: Colors.red,
                                    size: 20,
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              TextWidget(
                                text: product.price.toString(),
                                color: Colors.black,
                                textSize: 17,
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
