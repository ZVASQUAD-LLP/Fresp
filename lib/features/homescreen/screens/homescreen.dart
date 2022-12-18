import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fresp/common/widgets/sale_widget.dart';
import 'package:fresp/common/widgets/text_widget.dart';
import 'package:fresp/common/widgets/utils.dart';
import 'package:fresp/features/admin/screens/add_product_screen.dart';
import 'package:fresp/features/admin/services/admin_services.dart';
import 'package:fresp/features/admin/widgets/productList.dart';
import 'package:fresp/features/auth/services/auth_service.dart';
import 'package:fresp/features/homescreen/widgets/home_page_items.dart';
import 'package:fresp/models/category.dart';

import '../../../constants/global_variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  final List<String> assetImages = [
    'assets/images/home1.jpg',
    'assets/images/home2.jpg',
    'assets/images/home3.jpg',
  ];
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  late ScrollController _scrollController;
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
    getCategories();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getscreenSize;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  BoxDecoration(gradient: GlobalVariables.appBarGradient),
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
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: size.height * 0.30,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            assetImages[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                  autoplay: true,
                  itemCount: assetImages.length,
                  // ignore: prefer_const_constructors
                  // pagination: SwiperPagination(
                  //     alignment: Alignment.bottomCenter,
                  //     // ignore: prefer_const_constructors
                  //     builder: DotSwiperPaginationBuilder(
                  //         color: Colors.white,
                  //         activeColor: Color.fromARGB(255, 12, 230, 19))),
                )),
            // HomePageItems(headingCategory: "Fruits"),
            // SizedBox(
            //   height: 15,
            // ),
            // HomePageItems(headingCategory: "Vegetables"),
            // SizedBox(
            //   height: 15,
            // ),
            // HomePageItems(headingCategory: "Groceries"),
            productCategories == null
                ? const Center(
                    child: Text("Empty"),
                  )
                : Container(
                    height: 420,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: productCategories?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        color:
                                            GlobalVariables.selectedNavBarColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ProductList(
                                  category: productCategories![index].id),
                            ],
                          )),
                        );
                      },
                    ),
                  ),
          ]),
        ));
  }
}
