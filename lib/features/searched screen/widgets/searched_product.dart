// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:fresp/common/widgets/text_widget.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/product/screen/product_details.dart';
import 'package:fresp/features/product/services/product_service.dart';
import 'package:fresp/models/product.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductService productService = ProductService();
    void addToCart() {
      productService.addToCart(context: context, product: product);
    }

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routename,
              arguments: product);
        },
        child: Container(
          height: 90,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              product.images[0],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: product.name,
                                color: Colors.black,
                                textSize: 17,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
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
                                  onTap: addToCart,
                                  child: const Icon(
                                    (FeatherIcons.shoppingBag),
                                    color: Colors.black,
                                    size: 25,
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              TextWidget(
                                text: '\₹ ' + product.price.toString(),
                                color: GlobalVariables.secondaryColorRed,
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
