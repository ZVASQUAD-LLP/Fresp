import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/admin/screens/add_product_screen.dart';
import 'package:fresp/features/admin/services/admin_services.dart';
import 'package:fresp/features/admin/widgets/productList.dart';
import 'package:fresp/models/category.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<CategoryList>? productCategories = [];
  final AdminServices adminServices = AdminServices();
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void getCategories() async {
    var productCategoriesList = await adminServices.getCategories(context);

    setState(() {
      productCategories = productCategoriesList;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: productCategories == null
          ? const Center(
              child: Text("Empty"),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: productCategories?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              productCategories![index].name,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              'See all',
                              style: TextStyle(
                                fontSize: 18,
                                color: GlobalVariables.selectedNavBarColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ProductList(category: productCategories![index].id),
                    ],
                  )),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(FeatherIcons.plus),
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
