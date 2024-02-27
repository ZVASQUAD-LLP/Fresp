import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fresp/common/widgets/custom_text_field.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/constants/utils.dart';
import 'package:fresp/features/address/services/Address_services.dart';
import 'package:fresp/features/order/widgets/orders_widget.dart';
import 'package:fresp/features/order/screen/order_screen.dart';
import '../../../common/widgets/text_widget.dart';
import '../../../common/widgets/utils.dart';

class AddAddressScreen extends StatefulWidget {
  static const String routeName = '/add-address-screen';
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final addressFormKey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController towncityController = TextEditingController();
  // final TextEditingController landmarkController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    towncityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void addAddress() {
      if (_addressFormKey.currentState!.validate()) {
        addressServices.addAddress(context,
            street: areaController.text,
            apartment: flatBuildingController.text,
            zip: pincodeController.text,
            city: towncityController.text);
      }
      showSnackBar(context, 'Success!',
          'Address added successfully. Click Next to proceed', 1);
    }

    void navigateToOrderScreen() {
      Navigator.pushNamed(context, OrderScreen.routeName,
          arguments: OrderScreen);
    }

    final Color color = Utils(context).color;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            leading: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: Icon(FeatherIcons.arrowLeft),
            ),
            flexibleSpace: Container(
              decoration:
                  BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/images/logo_transperant.png',
                      width: 150, height: 100, color: Colors.black),
                ),
                // Container(
                //     padding: const EdgeInsets.only(left: 15, right: 15),
                //     child: Icon(FeatherIcons.user) //TODO: change icon

                //     ),
              ],
            ),
          ),
        ),
        body: Container(
            child: Form(
                key: _addressFormKey,
                child: Container(
                  margin: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Shipping Address Details:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),

                      const SizedBox(height: 5),
                      CustomTextField(
                        controller: flatBuildingController,
                        hintText: 'Flat,House Number,Building',
                      ),
                      const SizedBox(height: 5),
                      CustomTextField(
                        controller: areaController,
                        hintText: 'Area,Street',
                      ),
                      const SizedBox(height: 5),
                      CustomTextField(
                        controller: pincodeController,
                        hintText: 'Pincode',
                      ),
                      const SizedBox(height: 5),
                      CustomTextField(
                        controller: towncityController,
                        hintText: 'Town/City',
                      ),
                      const SizedBox(height: 5),
                      // CustomTextField(
                      //   controller: landmarkController,
                      //   hintText: 'Landmark',
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Material(
                                      color:
                                          GlobalVariables.secondaryColorYellow,
                                      borderRadius: BorderRadius.circular(8),
                                      child: InkWell(
                                          onTap: addAddress,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 17),
                                            child: TextWidget(
                                              text: 'Save Address',
                                              textSize: 15,
                                              color: Colors.black,
                                              isTitle: true,
                                            ),
                                          ))),
                                  Material(
                                      color:
                                          GlobalVariables.secondaryColorYellow,
                                      borderRadius: BorderRadius.circular(8),
                                      child: InkWell(
                                          onTap: navigateToOrderScreen,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 55, vertical: 17),
                                            child: TextWidget(
                                              text: 'Next',
                                              textSize: 15,
                                              color: Colors.black,
                                              isTitle: true,
                                            ),
                                          ))),
                                ]),
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
