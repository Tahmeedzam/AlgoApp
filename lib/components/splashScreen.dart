import 'package:algosapp/navigators/BottomNav.dart';
import 'package:algosapp/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to HomePage after delay
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNav()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 54, 54, 54),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/json/AlgoAnimation.json',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Gathering Knowledge...',
            style: TextStyle(fontSize: 16, color: Color(0xff7D7D7D)),
          ),
        ],
      ),
    );
  }
}
