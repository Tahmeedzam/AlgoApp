import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  const CustomTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        decoration: InputDecoration(
          label: Text(
            '$text',
            style: const TextStyle(color: Color(0xffE0E0E0)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff7D7D7D), // yellow when not focused
              width: 2,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.amber, // yellow when focused
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
