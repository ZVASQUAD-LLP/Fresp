import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fresp/features/admin/services/admin_services.dart';
import 'package:fresp/features/categories/widgets/categories_widgets.dart';
import 'package:fresp/features/searched%20screen/screens/searched_screen.dart';
import 'package:fresp/models/category.dart';

import '../../../constants/global_variables.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<CategoryList>? productCategories = [];
  final AdminServices adminServices = AdminServices();
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
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
      body: ListView.builder(
        itemCount: productCategories?.length,
        itemBuilder: (BuildContext context, int index) {
          return CategoriesWidget(
            category: productCategories![index].name,
            categoryId: productCategories![index].id,
          );
        },
      ),
    );
  }
}
