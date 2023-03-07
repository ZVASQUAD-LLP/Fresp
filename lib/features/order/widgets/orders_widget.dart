import "package:flutter/material.dart";
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fresp/common/widgets/custom_button.dart';
import 'package:fresp/common/widgets/text_widget.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/constants/utils.dart';
import 'package:fresp/features/address/screen/address_screen.dart';
import 'package:fresp/features/address/screen/add_address_screen.dart';
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
  // final _razorpay = Razorpay();
  final _razorpay = Razorpay();
  final AddressServices addressServices = AddressServices();
  final OrderServices orderServices = OrderServices();
  List<Address> addresses = [];

  String? address = "fetching";

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getAddresses();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   print("Payment Success");
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   print("Payment Error");
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   print("External Wallet");
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _razorpay.clear();
  // }

  // @override
  // void initState() {
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  //   super.initState();
  //   getAddresses();
  // }

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

    void navigateToAddressScreen() {
      Navigator.pushNamed(context, AddAddressScreen.routeName,
          arguments: AddAddressScreen);
    }

    String sum_round = sum.toStringAsFixed(2);
    int sum_paise = sum.toInt() * 100; //for razorpay
    void createOrder() async {
      order_id = await orderServices.createOrder(context, address!);
      var options = {
        'key': 'rzp_test_L63XqMTT9XVghC',
        'amount': sum_paise, //in the smallest currency sub-unit.
        'name': 'Fresp',
        //'order_id': order_id, // Generate order_id using Orders API
        'timeout': 500, // in seconds
        'prefill': {
          'contact': user.number,
          'email': user.email,
          'name': user.name
        },
        'external': {
          'wallets': ['paytm']
        }
      };
      try {
        _razorpay.open(options);
      } catch (e) {
        showSnackBar(context, "Error!", e.toString(), 0);
      }
    }

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Order Details:',
          style: TextStyle(color: GlobalVariables.secondaryColor, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Total Price: \₹ $sum_round',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          height: 230,
          child: ListView.builder(
            itemCount: user.cart.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black38, width: 1.5))),
                      // borderRadius: BorderRadius.circular(4)),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 310,
              child: DropdownButton(
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    address = newValue!;
                  });
                },
                value: address,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                items: addresses.map((Address item) {
                  return DropdownMenuItem(
                      value: item.id,
                      child: Text('${item.apartment}, ${item.street}'));
                }).toList(),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 30,
              child: FloatingActionButton(
                child: Icon(Icons.add_outlined),
                backgroundColor: GlobalVariables.secondaryColor,
                foregroundColor: Colors.black,
                onPressed: navigateToAddressScreen,
              ),
            ),
          ],
        ),
        CustomButton(
            text: "Proceed to Pay",
            backgroundColour: GlobalVariables.selectedNavBarColor,
            onTap: createOrder)
      ]),
    ));
  }
}
