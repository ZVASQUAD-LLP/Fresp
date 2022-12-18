import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fresp/providers/user_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  static const String routeName = '/test';
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Center(
        child: Text(user.toJson()),
      ),
    );
  }
}
// class TestScreen extends StatelessWidget {
//   static const String routeName = '/test';
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final user = Provider.of<UserProvider>(context).user;
//     // ignore: prefer_const_constructors
//     return Scaffold(
//       // ignore: prefer_const_constructors
//       body: Center(
//         child: const Text("working"),
//       ),
//     );
//   }
// }
