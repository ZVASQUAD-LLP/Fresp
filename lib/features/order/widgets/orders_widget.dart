import "package:flutter/material.dart";
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fresp/common/widgets/custom_button.dart';
import 'package:fresp/common/widgets/text_widget.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/constants/utils.dart';
import 'package:fresp/features/address/services/Address_services.dart';
import 'package:fresp/features/order/services/order_service.dart';
import 'package:fresp/features/order/widgets/custom_text_widget.dart';
import 'package:fresp/models/address.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({Key? key}) : super(key: key);

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  final _razorpay = Razorpay();
  final AddressServices addressServices = AddressServices();
  final OrderServices orderServices = OrderServices();
  List<Address> addresses = [];

  String? address = "fetching";
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Done");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("payment ERRORRRRRRRRR");
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print("external wallet selected");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
    getAddresses();
  }

  void getAddresses() async {
    var addressList = await addressServices.getAddress(context);
    setState(() {
      addresses = addressList;
      address = addressList[0].id;
    });
  }

  var order_id;
  @override
  Widget build(BuildContext context) {
    //final Color color =Utils(context).color;
    final user = Provider.of<UserDetailProvider>(context).user;
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as double)
        .toList();

    String sum_round = sum.toStringAsFixed(2);
    void createOrder() async {
      order_id = await orderServices.createOrder(context, address!);

      var options = {
        'key': 'rzp_test_L63XqMTT9XVghC',
        'amount': sum_round * 100, //in the smallest currency sub-unit.
        'name': 'Fresp',
        'order_id': order_id, // Generate order_id using Orders API
        'timeout': 300, // in seconds
        'prefill': {
          'contact': user.number,
          'email': user.email,
          'name': user.name
        }
      };
      try {
        _razorpay.open(options);
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Order Details:',
          style: TextStyle(color: Colors.red[400], fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Total Price: \₹$sum_round',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Container(
          height: 230,
          child: ListView.builder(
            itemCount: user.cart.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black12),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextWidget(
                          index: index,
                        ),
                      )));
            },
          ),
        ),
        const Text("Delivering to this address:"),
        SizedBox(
          width: double.infinity,
          child: DropdownButton(
            onChanged: (String? newValue) {
              setState(() {
                address = newValue!;
              });
            },
            value: address,
            icon: const Icon(FeatherIcons.arrowDown),
            items: addresses.map((Address item) {
              return DropdownMenuItem(
                  value: item.id,
                  child: Text('${item.apartment}, ${item.street}'));
            }).toList(),
          ),
        ),
        CustomButton(
            text: "Proceed to Pay",
            backgroundColour: GlobalVariables.secondaryColor,
            onTap: createOrder)
      ]),
    );
  }
}
