import 'package:flutter/material.dart';
import 'package:mobile_final/Pages/Admin.dart';
class Navbar extends StatefulWidget {
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentIndex = 1;
  List<Widget> body = const [
    Icon(Icons.home),
    Icon(Icons.perm_contact_calendar_sharp),
    Icon(Icons.add_chart),
    Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: Center(
        child: body[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int newIndex){
          setState(() {
            currentIndex = newIndex;
          });
        },
        fixedColor: const Color(0xff262F3E),
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Authors',
            icon: Icon(Icons.perm_contact_calendar_sharp),
          ),
          BottomNavigationBarItem(
            label: 'Shelf',
            icon: Icon(Icons.add_chart),
          ),
          BottomNavigationBarItem(
            label: 'Admin',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );*/
    return BottomNavigationBar(
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
    );
  }
}
