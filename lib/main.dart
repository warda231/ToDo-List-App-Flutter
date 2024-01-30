import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/LoginScreen.dart';
import 'package:flutter_application_1/Views/SplashScreen.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 /* try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyDjpe7lWgZDwXem-RqTJr_xZbmJ8oyf2AI",
          appId: "1:129776743637:web:8df47e4c2b29f3c5e91e5c",
          authDomain: "todo-list-app-cb9f7.firebaseapp.com",
          messagingSenderId: "129776743637",
          projectId: "todo-list-app-cb9f7",
        ),
      );
    } else {
      await Firebase.initializeApp(

      );
    }
  } catch (e) {
    print("Firebase initialization failed: $e");
  }*/
  await Firebase.initializeApp();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}


