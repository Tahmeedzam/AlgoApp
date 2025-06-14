import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

Widget myCustomDropDown({
  required String? value,
  required ValueChanged<String?> onChanged,
  required List<String> categories,
}) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  child: CustomDropdown<String>(
    hintText: 'Select Category',
    items: categories,
    initialItem: value,
    decoration: CustomDropdownDecoration(
      closedBorder: BoxBorder.all(color: Color(0xFF606060), width: 1.25),
      closedFillColor: Color(0xff1A1A1A),
      expandedFillColor: Color(0xff1A1A1A),
      headerStyle: TextStyle(color: Color(0xffE0E0E0)),
      listItemStyle: TextStyle(color: Color(0xffE0E0E0), fontSize: 16),
    ),
    onChanged: onChanged,
  ),
);
