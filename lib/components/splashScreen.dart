import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:algosapp/navigators/BottomNav.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller with higher speed (e.g. 2x)
    _controller = AnimationController(vsync: this);

    // Navigate after 4 seconds (adjust if animation is shorter due to faster speed)
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNav()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              controller: _controller,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              onLoaded: (composition) {
                // Set speed: 2.0 means 2x faster
                _controller
                  ..duration = composition.duration
                  ..repeat(); // or .forward() for one-time play
                _controller.value = 0.0;
                _controller.animateTo(
                  1.0,
                  duration: composition.duration * (1 / 2.0),
                );
              },
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
