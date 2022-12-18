import 'package:flutter/material.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fresp/common/widgets/text_widget.dart';
import 'package:fresp/common/widgets/utils.dart';

class EmptyCartScreen extends StatefulWidget {
  static const String routeName = '/empty_screen';
  const EmptyCartScreen({Key? key}) : super(key: key);

  @override
  State<EmptyCartScreen> createState() => _EmptyCartScreenState();
}

class _EmptyCartScreenState extends State<EmptyCartScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: TextWidget(
          text: 'Cart(0)',
          color: Color.fromARGB(255, 255, 255, 255),
          textSize: 22,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              IconlyBroken.delete,
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
