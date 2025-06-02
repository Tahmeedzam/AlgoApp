import 'package:flutter/material.dart';

class smallCard extends StatelessWidget {
  const smallCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 75,
        width: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          border: BoxBorder.fromLTRB(
            left: BorderSide(color: Color(0xffFFD300), width: 14),
          ),
          color: Color(0xff1A1A1A),
        ),
      ),
    );
  }
}
