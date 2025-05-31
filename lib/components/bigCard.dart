import 'package:flutter/material.dart';

class bigCard extends StatelessWidget {
  const bigCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(height: 200, color: Color(0xff1A1A1A)),
    );
  }
}
