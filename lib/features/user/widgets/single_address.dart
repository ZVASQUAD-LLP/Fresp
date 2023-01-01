// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fresp/features/address/services/Address_services.dart';
import 'package:fresp/models/address.dart';
import 'package:fresp/models/order.dart';

class SingleAddress extends StatefulWidget {
  const SingleAddress({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleAddress> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleAddress> {
  final AddressServices addressServices = AddressServices();
  List<Address> addresses = [];
  String? address = "fetching";
  void getAddresses() async {
    var addressList = await addressServices.getAddress(context);
    setState(() {
      addresses = addressList;
      address = addressList[0].id;
    });
  }

  @override
  void initState() {
    super.initState();
    getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.black87,
      elevation: 5,
      surfaceTintColor: Colors.black,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: addresses.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(
                    '${addresses[index].apartment}, ${addresses[index].street}'),
              );
            })),
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 5),
    //   child: DecoratedBox(
    //     decoration: BoxDecoration(
    //         border: Border.all(color: Colors.black12, width: 1.5),
    //         borderRadius: BorderRadius.circular(5),
    //         color: Colors.white),
    //     child: SizedBox(
    //       width: 150,
    //       child: DropdownButton(
    //         isExpanded: true,
    //         onChanged: (String? newValue) {
    //           setState(() {
    //             address = newValue!;
    //           });
    //         },
    //         value: address,
    //         icon: const Icon(Icons.arrow_drop_down_rounded),
    //         items: addresses.map((Address item) {
    //           return DropdownMenuItem(
    //               value: item.id,
    //               child: Text('${item.apartment}, ${item.street}'));
    //         }).toList(),
    //       ),
    //     ),
    //   ),
    // );
  }
}
