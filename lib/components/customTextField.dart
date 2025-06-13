import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(
            '$label',
            style: const TextStyle(color: Color(0xffE0E0E0), fontSize: 16),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff7D7D7D), // yellow when not focused
              width: 2,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffFFD300), // yellow when focused
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
