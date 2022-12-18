// // ignore_for_file: file_names, unused_import, camel_case_types, prefer_const_constructors_in_immutables, unused_field

// import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class paymentChecout extends StatefulWidget {
//   paymentChecout({Key? key}) : super(key: key);

//   @override
//   State<paymentChecout> createState() => _paymentChecoutState();
// }

// class _paymentChecoutState extends State<paymentChecout> {
//   var _razorpay = Razorpay();

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }
//   var options = {
//   'key': '<YOUR_KEY_ID>',
//   'amount': 50000, //in the smallest currency sub-unit.
//   'name': 'Acme Corp.',
//   'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
//   'description': 'Fine T-Shirt',
//   'timeout': 60, // in seconds
//   'prefill': {
//     'contact': '9123456789',
//     'email': 'gaurav.kumar@example.com'
//   }
// };
// try {
//   _razorpay.open(options);
// }catch (e) {
//   debugPrint(e);
// }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Do something when payment succeeds
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Do something when payment fails
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Do something when an external wallet is selected
//   }
// }
