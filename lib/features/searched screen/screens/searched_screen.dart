// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/product/services/product_service.dart';
import 'package:fresp/features/searched%20screen/widgets/searched_product.dart';
import 'package:fresp/models/product.dart';

class SearchedScreen extends StatefulWidget {
  static const String routename = '/searched-screen';
  final String? category;
  const SearchedScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<SearchedScreen> createState() => _SearchedScreenState();
}

class _SearchedScreenState extends State<SearchedScreen> {
  ProductService productService = ProductService();
  List<Product> productList = [];
  void getProducts() async {
    var products = await productService.getProducts(context, widget.category!);

    setState(() {
      productList = products;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: Icon(FeatherIcons.arrowLeft),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/amazon_in.png',
                    width: 120, height: 45, color: Colors.black),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Icon(FeatherIcons.user) //TODO: change icon

                  ),
            ],
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) {
            return SearchedProduct(product: productList[index]);
          },
        ),
      ),
    );
  }
}
