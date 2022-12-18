// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
          width: double.infinity,
          height: 60,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 0.5, color: Colors.black),
              ),
              onPressed: navigateToSearchedScreen,
              child: Text(
                category,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ))),
    );
  }
}
