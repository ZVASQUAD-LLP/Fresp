// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fresp/common/widgets/sale_widget.dart';
import 'package:fresp/common/widgets/sale_widget_admin.dart';

import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/product/services/product_service.dart';
import 'package:fresp/features/user/widgets/single_product.dart';
import 'package:fresp/models/product.dart';

class ProductList extends StatefulWidget {
  final String? category;
  const ProductList({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ProductList> createState() =>
      _ProductListState(category: this.category);
}

class _ProductListState extends State<ProductList> {
  String? category;
  ProductService productService = ProductService();
  _ProductListState({required this.category});
  List<Product> productList = [];
  void getProducts() async {
    var products = await productService.getProducts(context, category!);

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
    return Container(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              SaleWidgetAdmin(
                product: productList[index],
              ),
            ],
          );
        },
      ),
    );
  }
}
