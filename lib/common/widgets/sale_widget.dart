// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:fresp/common/widgets/utils.dart';
// import 'package:fresp/features/cart/screen/cart_screen.dart';
// import 'price_widget.dart';
// import 'text_widget.dart';
// import '../../features/product/screen/product_details.dart';

// class SaleWidget extends StatefulWidget {
//   const SaleWidget({Key? key}) : super(key: key);

//   @override
//   State<SaleWidget> createState() => _SaleWidgetState();
// }

// class _SaleWidgetState extends State<SaleWidget> {
//   void navigateToCart() {
//     Navigator.pushNamed(context, CartScreen.routeName, arguments: CartScreen);
//   }

//   void navigateToProduct() {
//     Navigator.pushNamed(context, ProductDetails.routename,
//         arguments: ProductDetails);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color color = Utils(context).color;
//     Size size = Utils(context).getscreenSize;

//     return GestureDetector(
//         onTap: () {
//           navigateToProduct();
//         },
//         child: Container(
//             margin: const EdgeInsets.all(5),
//             child: Material(
//               borderRadius: BorderRadius.circular(5),
//               color: Color.fromARGB(255, 245, 244, 244),
//               child: InkWell(
//                   borderRadius: BorderRadius.circular(5),
//                   onTap: () {
//                     navigateToProduct();
//                   },
//                   child: Padding(
//                       padding: const EdgeInsets.all(7.0),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Container(
//                                 decoration: const BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Color(0x54000000),
//                                       spreadRadius: 10,
//                                       blurRadius: 2,
//                                     ),
//                                   ],
//                                 ),
//                                 child: Image.network(
//                                   'https://media.istockphoto.com/photos/farm-market-in-the-fall-apples-picture-id1088157488',
//                                   width: size.width * 0.30,
//                                   height: size.width * 0.18,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 5.0),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       color: Colors.transparent,
//                                       width: 100,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           TextWidget(
//                                             text: 'Apples',
//                                             color: color,
//                                             textSize: 15,
//                                             isTitle: true,
//                                           ),
//                                           const SizedBox(
//                                             height: 2,
//                                           ),
//                                           const PriceWidget(
//                                             price: 100.15,
//                                           ),
//                                           const SizedBox(height: 0.1),
//                                           TextWidget(
//                                               text: '1kg',
//                                               color: color,
//                                               textSize: 14,
//                                               isTitle: true),
//                                           const SizedBox(height: 0.1),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       child:
//                                           const Icon(FeatherIcons.shoppingBag),
//                                     )
//                                   ]),
//                             )
//                           ]))),
//             )));
//   }
// }
