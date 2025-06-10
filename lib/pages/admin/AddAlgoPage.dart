import 'package:algosapp/components/customTextField.dart';
import 'package:flutter/material.dart';

class AddAlgoPage extends StatefulWidget {
  const AddAlgoPage({super.key});

  @override
  State<AddAlgoPage> createState() => _AddAlgoPageState();
}

class _AddAlgoPageState extends State<AddAlgoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0D0D0D),
      appBar: AppBar(
        backgroundColor: Color(0xff1A1A1A),
        title: Text(
          'Add New Algo',
          style: TextStyle(color: Color(0xffE0E0E0), fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                "Details:",
                style: TextStyle(color: Color(0xffE0E0E0), fontSize: 16),
              ),
            ),
            CustomTextField(text: 'Id:'),
            SizedBox(height: 15),
            CustomTextField(text: 'Name:'),
          ],
        ),
      ),
    );
  }
}
