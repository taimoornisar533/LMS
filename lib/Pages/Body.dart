import 'package:flutter/material.dart';
import 'package:mobile_final/Pages/Admin.dart';
import 'package:mobile_final/Pages/Authors.dart';
import 'package:mobile_final/Pages/Shelf.dart';
import 'package:mobile_final/Pages/Home.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex = 1;
  final screens = <Widget>[
    Home(),
    Authors(),
    Shelf(),
    AdminPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int newIndex){
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
            backgroundColor: Color(0xff262F3E),
          ),
          BottomNavigationBarItem(
            label: 'Authors',
            icon: Icon(Icons.perm_contact_calendar_sharp),
            backgroundColor: Color(0xff262F3E),
          ),
          BottomNavigationBarItem(
            label: 'Shelf',
            icon: Icon(Icons.add_chart),
            backgroundColor: Color(0xff262F3E),
          ),
          BottomNavigationBarItem(
            label: 'Admin',
            icon: Icon(Icons.person),
            backgroundColor: Color(0xff262F3E),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
    );
  }
}
