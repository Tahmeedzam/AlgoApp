import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0D0D0D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Color(0xff7D7D7D)),
                        filled: true,
                        fillColor: Color(0xff1A1A1A),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset(
                            'assets/icons/search.png',
                            color: Color(0xffFFD300),
                            height: 10,
                            width: 10,
                          ),
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Filter Icon with spacing
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/icons/filter.png',
                        color: Color(0xffFFD300),
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),

              Container(height: 20, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
