import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fresp/common/widgets/custom_text_field.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/address/services/Address_services.dart';

import '../../../common/widgets/text_widget.dart';
import '../../../common/widgets/utils.dart';

class AddressScreen extends StatefulWidget {
  // static const String routeName = '/address-screen';
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
    }

    final Color color = Utils(context).color;
    return Container(
        child: Form(
            key: _addressFormKey,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Shipping Address Details:',
                      style: TextStyle(
                        fontSize: 23,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: Column(
                      children: [
                        Material(
                            color: GlobalVariables.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                                onTap: addAddress,
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  child: TextWidget(
                                    text: 'Save Address',
                                    textSize: 15,
                                    color: Colors.white,
                                    isTitle: true,
                                  ),
                                ))),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
