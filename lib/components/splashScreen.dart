import 'package:algosapp/navigators/AdminBottomNav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after 2 seconds (2000 ms)
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AdminBottomNav()), // or your page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SpinKitFadingCube(
              color: Color(0xffFFD300),
              duration: Duration(milliseconds: 2000),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              "Gathering Algorithms...",
              style: TextStyle(fontSize: 16, color: Color(0xff7D7D7D)),
            ),
          ),
        ],
      ),
    );
  }
}
