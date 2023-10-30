// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utils/authorization.dart';
import 'package:flutter_application_1/Views/HomePage.dart';
import 'package:flutter_application_1/Views/HomeScreen.dart';
import 'package:flutter_application_1/Views/SignupScreen.dart';
import 'package:flutter_application_1/common_widgets/button.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widgets/text_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   
  //final GoogleSignIn googleSignIn = GoogleSignIn(); 
  String? name, imageUrl, userEmail, uid; 
  bool isLoading=false;
   TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
   
    final _formKey = GlobalKey<FormState>();

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
                  height: screenHeight * 0.75,
                  width: screenWidth * 0.7,
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
                          'Login ',
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
                          controller: _emailController,
                          txt: 'Email',
                          val: false,
                          icon: Icons.person,
                          color: const Color.fromARGB(255, 224, 218, 218),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "*required";
                            } else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 8, top: 8),
                        child: txtWidget(
                          controller: _passwordController,
                          txt: 'Password',
                          icon: Icons.lock,
                          val: true,
                          color: const Color.fromARGB(255, 224, 218, 218),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      isLoading==true? CircularProgressIndicator()
                     : button(
                        text: 'Login',
                        color: const Color.fromARGB(255, 237, 182, 200),
                        onPress: () {
                          if (_formKey.currentState!.validate()){
                         _signin();

                          }
                        },
                        textColor: Colors.white,
                      ),
                      Text(
                        'Create a new account',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      button(
                        text: 'Signup',
                        textColor: const Color.fromARGB(255, 237, 182, 200),
                        onPress: () {
                          Get.to(SignupPage());
                        },
                        color: Colors.white,
                      ),
                      Text(
                        'Login with',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 168, 162, 162),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {
                               signinWithGoogle();
                              },
                              child: CircleAvatar(
                                child: Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/720/720255.png',
                                  width: 30,
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 209, 207, 207),
                                radius: 25,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                child: Image.network(
                                  'https://png.pngtree.com/element_our/sm/20180515/sm_5afaf0c4b6017.jpg',
                                  width: 30,
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 209, 207, 207),
                                radius: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }

  void _signin()async{
     
          try{
             final email=_emailController.text;
            final password=_passwordController.text;
            isLoading=true;
          User? user=await Signin(email, password);
            if(user!=null){
              print('user login successfully');
              String uid=user.uid;
              Get.offAll(HomePage());
              Get.snackbar( 'Success',
          'You login successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
          );
            }else{
               Get.snackbar(
          'Error',
          'Try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
            }
          }catch(e){
            print('Something went wrong $e');
          }finally{
            isLoading=false;
          }


  }
   
}
