// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/admin/screens/admin_screen.dart';
import 'package:fresp/features/auth/screens/auth_screen.dart';
import 'package:fresp/features/auth/services/auth_service.dart';
import 'package:fresp/common/widgets/bottom_bar.dart';
import 'package:fresp/providers/user_detail_provider.dart';
import 'package:fresp/providers/user_provider.dart';
import 'package:fresp/router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserDetailProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  final String? initialRoute;
  const MyApp({
    this.initialRoute,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fresp',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              )),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.isAdmin == false
                ? const BottomBarScreen()
                : AdminScreen()
            : const AuthScreen());
  }
}
