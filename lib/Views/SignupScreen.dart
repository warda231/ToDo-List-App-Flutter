// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utils/authorization.dart';
import 'package:flutter_application_1/Views/HomePage.dart';
import 'package:flutter_application_1/Views/HomeScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../common_widgets/button.dart';
import '../common_widgets/text_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;
  bool isLoading = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidhth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 252, 238, 105), Colors.white],
            stops: [0.0, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              width: screenWidhth * 0.7,
              height: screenHeight * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, // Shadow color
                    offset: Offset(0, 2),
                    blurRadius: 4, // Blur radius of the shadow
                    spreadRadius: 1, // Spread radius of the shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Signup ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 8, top: 8),
                    child: txtWidget(
                      controller: usernameController,
                      txt: 'Username',
                      val: false,
                                                icon: Icons.person,

                      color: const Color.fromARGB(255, 224, 218, 218),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 8, top: 8),
                    child: txtWidget(
                      controller: emailController,
                      txt: 'Enter Email',
                                                icon: Icons.email,

                      val: false,
                      color: const Color.fromARGB(255, 224, 218, 218),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 8, top: 8),
                    child: txtWidget(
                      controller: passwordController,
                      txt: 'Enter Password',
                                                icon: Icons.lock,

                      val: true,
                      color: const Color.fromARGB(255, 224, 218, 218),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 8, top: 8),
                    child: txtWidget(
                      controller: confirmpasswordController,
                      txt: 'Repeat Password',
                                                icon: Icons.lock,

                      val: true,
                      color: const Color.fromARGB(255, 224, 218, 218),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                      Text(
                        'Agree to our terms and policies',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  isLoading == true
                      ? CircularProgressIndicator()
                      : button(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              _signup();
                            }
                          },
                          text: 'Signup',
                          color: const Color.fromARGB(255, 237, 182, 200),
                          textColor: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signup() async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmpass = confirmpasswordController.text;
    isLoading = true;
    User? user = await Signup(email, password, username);
    try {
      if (user != null) {
        print('user create account successfully');
        String uid = user.uid;
        Get.offAll(HomePage());
        Get.snackbar(
          'Success',
          'You account has been created',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
        return storeUserData(username, email, password, confirmpass, uid);
      } else {
        debugPrint('error occured');
        Get.snackbar(
          'Error',
          'Something went wrong, try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      print('error occured $e');
    } finally {
      isLoading = false;
    }
  }
}
