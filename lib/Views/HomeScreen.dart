// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/AccounScreen.dart';
import 'package:flutter_application_1/Views/History.dart';
import 'package:flutter_application_1/Views/HomePage.dart';
import 'package:flutter_application_1/Views/Settings.dart';

import '../common_widgets/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexpg=0;
     ontap(int index){
      setState(() {

        indexpg=index;
      });

    }
  @override
  Widget build(BuildContext context) {
    

    
    var navsbar = [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.grey,
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.timelapse,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.grey,
        label: 'History',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.grey,
        label: 'Settings',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.grey,
        label: 'Account',
      ),
    ];

    var pages = [
      Home(),
           HistoryPage (),

      SettingsPage(),
      AccountScreen(),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      
      body: Center(child: pages.elementAt(indexpg),  
),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexpg,
        items: navsbar,
        backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          unselectedItemColor: const Color.fromARGB(255, 19, 92, 151),
          selectedLabelStyle: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
                  onTap: (index) => ontap(index),

        ),
    );
  }
}