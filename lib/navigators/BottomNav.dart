import 'package:algosapp/pages/ContactUsPage.dart';
import 'package:algosapp/pages/HomePage.dart';
import 'package:algosapp/pages/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomePage(), ProfilePage(), ContactUsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 37, 37, 37),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SafeArea(
          child: GNav(
            gap: 8,
            backgroundColor: Color.fromARGB(255, 37, 37, 37),
            color: Colors.white,
            activeColor: Color(0xffFFD300),
            tabBackgroundColor: Color(0xff2A2A2A),
            padding: const EdgeInsets.all(12),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() => _selectedIndex = index);
            },
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.person, text: 'Profile'),
              GButton(icon: Icons.mail, text: 'Contact'),
            ],
          ),
        ),
      ),
    );
  }
}
