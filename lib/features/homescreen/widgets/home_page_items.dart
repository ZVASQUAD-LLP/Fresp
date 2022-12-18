// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import '../../../common/widgets/sale_widget.dart';
// import '../../../common/widgets/utils.dart';

// class HomePageItems extends StatelessWidget {
//   final String headingCategory;
//   const HomePageItems({
//     Key? key,
//     required this.headingCategory,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = Utils(context).getscreenSize;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15),
//             child: Text(
//               headingCategory,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Container(
//           height: size.height * 0.20,
//           child: ListView.builder(
//             itemCount: 10,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: ((context, index) {
//               return const SaleWidget();
//             }),
//           ),
//         ),
//       ],
//     );
//   }
// }
