import 'package:algosapp/navigators/AdminBottomNav.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:algosapp/navigators/BottomNav.dart';
import 'dart:ui';

class LoadingCircle extends StatefulWidget {
  @override
  State<LoadingCircle> createState() => _LoadingCircleState();
}

class _LoadingCircleState extends State<LoadingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller with higher speed (e.g. 2x)
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Scaffold(
        backgroundColor: Color.fromARGB(37, 99, 99, 99),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator()),
            SizedBox(height: 20),
            Text(
              'Uploading data',
              style: TextStyle(fontSize: 16, color: Color(0xff7D7D7D)),
            ),
          ],
        ),
      ),
    );
  }
}
