import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/HomeScreen.dart';
import 'package:flutter_application_1/Views/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  splashsc() {
    if (user != null) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.to(() => HomePage());
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Get.to(() => LoginPage());
      });
    }
  }

  @override
  void initState() {
    splashsc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'ToDo List App',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              '@Warda Devs',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
