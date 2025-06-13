import 'package:flutter/material.dart';

Widget customlabel(String txt) => Padding(
  padding: const EdgeInsets.only(left: 24),
  child: Align(
    alignment: AlignmentDirectional.centerStart,
    child: Text(
      txt,
      style: const TextStyle(color: Color(0xffE0E0E0), fontSize: 16),
    ),
  ),
);
