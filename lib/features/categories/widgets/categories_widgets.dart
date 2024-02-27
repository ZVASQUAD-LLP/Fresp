// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fresp/features/searched%20screen/screens/searched_screen.dart';

class CategoriesWidget extends StatelessWidget {
  final String category;
  final String? categoryId;
  const CategoriesWidget({
    Key? key,
    required this.category,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToSearchedScreen() {
      Navigator.pushNamed(context, SearchedScreen.routename,
          arguments: categoryId);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.black38, width: 1.5))),
          width: double.infinity,
          height: 60,
          child: ListTile(
            title: Text(category,
                style: const TextStyle(color: Colors.black, fontSize: 20)),
            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () =>
                        navigateToSearchedScreen() // icon-1// icon-2
                    )
              ],
            ),
          )),
    );
  }
}
