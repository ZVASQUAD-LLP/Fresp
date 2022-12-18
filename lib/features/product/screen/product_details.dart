// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:fresp/common/widgets/text_widget.dart';
import 'package:fresp/common/widgets/utils.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/product/services/product_service.dart';
import 'package:fresp/models/product.dart';

class ProductDetails extends StatefulWidget {
  static const String routename = '/product-details';
  final Product product;
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetails> {
  // Product product = Product(
  //     name: '',
  //     description: '',
  //     images: [],
  //     brand: '',
  //     price: 0,
  //     countInStock: 0);
  final ProductService productService = ProductService();
  // void getProduct() async {
  //   var productRes = await productService.getProduct(context, widget.);
  //   setState(() {
  //     product = productRes;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getProduct();
  }

  void addToCart() {
    productService.addToCart(context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreenSize;

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                      text: widget.product.brand, color: color, textSize: 15),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                height: size.height * 0.40,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(widget.product.images[index],
                        height: 300, width: 500, fit: BoxFit.fill);
                  },
                  autoplay: false,
                  itemCount: widget.product.images.length,
                  // ignore: prefer_const_constructors
                  pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      // ignore: prefer_const_constructors
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white,
                          activeColor: Color.fromARGB(255, 233, 58, 5))),
                )),
            Container(
              color: Color.fromARGB(255, 110, 109, 109),
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: ' Price: ',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(31, 10, 10, 10),
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: (widget.product.price).toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                widget.product.description,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              color: Color.fromARGB(255, 110, 109, 109),
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Material(
                    color: const Color.fromARGB(255, 226, 138, 6),
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 90, vertical: 10),
                          child: TextWidget(
                            text: 'Buy Now',
                            textSize: 25,
                            color: Colors.black,
                          ),
                        ))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Material(
                  color: const Color.fromARGB(255, 54, 177, 5),
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: addToCart,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 90, vertical: 10),
                        child: TextWidget(
                          text: 'Add to Cart',
                          textSize: 20,
                          color: Colors.white,
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
