import 'package:flutter/material.dart';
import 'package:fresp/common/widgets/custom_button.dart';
import 'package:fresp/common/widgets/custom_text_Field.dart';
import 'package:fresp/constants/global_variables.dart';
import 'package:fresp/features/auth/services/auth_service.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signin;
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final AuthService authService = AuthService();
  @override
  void dispose() {
    super.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        number: _phoneNumberController.text);
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Center(child: Text('Fresp')),
        //   backgroundColor: GlobalVariables.selectedNavBarColor,
        // ),
        backgroundColor: GlobalVariables.backgroundColor,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180.0,
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/amazon_in.png',
                        width: 120, height: 60, color: Colors.black),
                  ),
                ),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? GlobalVariables.greyBackgroundCOlor
                      : GlobalVariables.backgroundColor,
                  title: const Text('Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(30.0),
                    color: GlobalVariables.greyBackgroundCOlor,
                    child: Form(
                      key: _signinFormKey,
                      child: Column(children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        // CustomButton(
                        //     text: 'Connect with Google',
                        //     backgroundColour: Color.fromARGB(255, 36, 83, 203),
                        //     onTap: () => {}),
                        // const SizedBox(height: 10),
                        FlatButton(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
                          onPressed: () {
                            //TODO FORGOT PASSWORD SCREEN GOES HERE
                          },
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: GlobalVariables.secondaryColor,
                                fontSize: 17),
                          ),
                        ),
                        CustomButton(
                            text: 'Sign in',
                            backgroundColour:
                                GlobalVariables.selectedNavBarColor,
                            onTap: () => {
                                  if (_signinFormKey.currentState!.validate())
                                    signInUser()
                                })
                      ]),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? GlobalVariables.greyBackgroundCOlor
                      : GlobalVariables.backgroundColor,
                  title: const Text('Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(30.0),
                    color: GlobalVariables.greyBackgroundCOlor,
                    child: Form(
                      key: _signupFormKey,
                      child: Column(children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _phoneNumberController,
                          hintText: 'Phone Number',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        // CustomButton(
                        //     text: 'Connect with Google',
                        //     backgroundColour: Color.fromARGB(255, 36, 83, 203),
                        //     onTap: () => {}),
                        // const SizedBox(height: 10),
                        CustomButton(
                            text: 'Sign Up',
                            backgroundColour:
                                GlobalVariables.selectedNavBarColor,
                            onTap: () => {
                                  if (_signupFormKey.currentState!.validate())
                                    signUpUser()
                                })
                      ]),
                    ),
                  ),
              ],
            ),
          )),
        ));
  }
}
