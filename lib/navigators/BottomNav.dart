import 'package:algosapp/pages/AIChatPage.dart';
import 'package:algosapp/pages/admin/AddAlgoPage.dart';
import 'package:algosapp/pages/HomePage.dart';
import 'package:algosapp/pages/ProfilePage.dart';
import 'package:algosapp/pages/contactPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomePage(), AIChatPage(), ContactPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 37, 37, 37),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SafeArea(
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            gap: 12, // spacing between icon and text
            backgroundColor: const Color.fromARGB(255, 37, 37, 37),
            color: Colors.white,
            activeColor: const Color(0xffFFD300),
            tabBackgroundColor: const Color(0xff2A2A2A),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() => _selectedIndex = index);
            },
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.chat, text: 'Algo AI'),
              GButton(icon: Icons.info_rounded, text: 'Contact'),
            ],
          ),
        ),
      ),
    );
  }
}
