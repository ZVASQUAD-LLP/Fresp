// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../widgets/utils.dart';
import 'text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    required this.price,
  }) : super(key: key);
  final double? price;
  @override
  Widget build(BuildContext context) {
    String price = (this.price).toString();
    final Color color = Utils(context).color;
    return SizedBox(
        child: Row(
      children: [
        TextWidget(text: price, color: Colors.red, isTitle: true, textSize: 17),
      ],
    ));
  }
}
