import 'package:algosapp/components/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

const List<String> _list = ['Developer', 'Designer', 'Consultant', 'Student'];

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
            CustomTextField(text: 'ID :'),
            SizedBox(height: 15),
            CustomTextField(text: 'Name :'),
            SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "Category :",
                  style: TextStyle(color: Color(0xffE0E0E0), fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomDropdown<String>(
                hintText: 'Select Category',
                items: _list,
                decoration: CustomDropdownDecoration(
                  closedBorder: BoxBorder.all(
                    color: Color(0xFF606060),
                    width: 1.25,
                  ),
                  closedFillColor: Color(0xff1A1A1A),
                  expandedFillColor: Color(0xff1A1A1A),
                  headerStyle: TextStyle(color: Color(0xffE0E0E0)),
                  listItemStyle: TextStyle(color: Color(0xffE0E0E0)),
                ),
                initialItem: _list[0],
                onChanged: (value) {},
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "Description :",
                  style: TextStyle(color: Color(0xffE0E0E0), fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                minLines: 1,
                maxLines: 8,
                style: TextStyle(color: Color(0xffE0E0E0)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xff1A1A1A),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFFD300)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF606060),
                      width: 1.25,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff1A1A1A),
                        border: Border.all(
                          color: Color(0xFF606060),
                          width: 1.25,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Next', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xFFFFD300),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
