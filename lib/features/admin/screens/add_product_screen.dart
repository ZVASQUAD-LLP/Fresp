import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fresp/common/widgets/custom_button.dart';
import 'package:fresp/common/widgets/custom_textField.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/constants/utils.dart';
import 'package:fresp/features/admin/services/admin_services.dart';
import 'package:fresp/models/category.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static const String routeName = "/addProduct";
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    brandController.dispose();
  }

  final AdminServices adminServices = AdminServices();
  List<File> images = [];
  List<CategoryList>? productCategories = [];
  String? category = "fetching...";
  final _addProductFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.SellProduct(
          context: context,
          name: productNameController.text,
          brand: brandController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: int.parse(quantityController.text),
          category: category,
          images: images);
    }
  }

  void getCategories() async {
    var productCategoriesList = await adminServices.getCategories(context);

    setState(() {
      productCategories = productCategoriesList;
      category = productCategoriesList[0].id;
    });
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
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
                decoration:
                    BoxDecoration(gradient: GlobalVariables.appBarGradient),
              ),
              title: const Text(
                "Add Product",
                style: TextStyle(color: Colors.black),
              )),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              images.isNotEmpty
                  ? CarouselSlider(
                      items: images.map(
                        (i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                      ))
                  : GestureDetector(
                      onTap: selectImages,
                      child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    FeatherIcons.folderPlus,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400),
                                  )
                                ]),
                          )),
                    ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                  controller: productNameController, hintText: 'Product Name'),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(controller: brandController, hintText: 'Brand'),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: descriptionController,
                hintText: 'Description',
                maxLines: 7,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(controller: priceController, hintText: 'Price'),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  controller: quantityController, hintText: 'Quantity'),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  onChanged: (String? newValue) {
                    setState(() {
                      category = newValue!;
                    });
                  },
                  value: category,
                  icon: const Icon(FeatherIcons.arrowDown),
                  items: productCategories?.map((CategoryList item) {
                    return DropdownMenuItem(
                        value: item.id, child: Text(item.name));
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  text: 'Sell',
                  backgroundColour: GlobalVariables.secondaryColor,
                  onTap: sellProduct)
            ]),
          ),
        )));
  }
}
