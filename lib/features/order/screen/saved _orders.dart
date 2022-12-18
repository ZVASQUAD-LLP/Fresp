import 'package:flutter/material.dart';
import 'package:fresp/common/widgets/text_widget.dart';
import 'package:fresp/common/widgets/utils.dart';
import 'package:fresp/features/order/widgets/orders_widget.dart';

class SavedOrders extends StatefulWidget {
  static const String routename = '/saved-orders';

  const SavedOrders({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedOrders> createState() => _SavedOrdersState();
}

class _SavedOrdersState extends State<SavedOrders> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
            ),
            title: TextWidget(
              text: 'Saved Orders',
              color: color,
              isTitle: true,
              textSize: 22,
            ),
          ),
        ),
        body: Column(
          children: [
            _checkout(ctx: context),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const OrdersWidget();
                },
              ),
            ),
          ],
        ));
  }

  Widget _checkout({
    required BuildContext ctx,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            FittedBox(
              child: TextWidget(
                text: 'Order History',
                color: Colors.black,
                textSize: 20,
                isTitle: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
