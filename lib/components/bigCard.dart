import 'package:flutter/material.dart';

class bigCard extends StatelessWidget {
  const bigCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8),
      child: Container(
        height: 200,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff1A1A1A),
        ),
      ),
    );
  }
}
