import 'package:algosapp/components/bigCard.dart';
import 'package:algosapp/components/smallCard.dart';
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
      appBar: AppBar(
        title: Center(
          child: Text(
            'Algo-Verse',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xffE0E0E0),
              letterSpacing: 4,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xff0D0D0D),
      body: SafeArea(
        child: Column(
          children: [
            // Filter based cards
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        bigCard(),
                        const SizedBox(width: 8),
                        bigCard(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // 🔍 Search bar and filter icon
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Color(0xff7D7D7D)),
                            filled: true,
                            fillColor: const Color(0xff1A1A1A),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(
                                'assets/icons/search.png',
                                color: const Color(0xffFFD300),
                                height: 10,
                                width: 10,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/icons/filter.png',
                            color: const Color(0xffFFD300),
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 🟨 Horizontal big cards
                  const SizedBox(height: 30),

                  // 🟨 Recommended title
                  const Text(
                    'Recommended:',
                    style: TextStyle(fontSize: 16, color: Color(0xff7D7D7D)),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),

            // ✅ Expanded vertical list outside padding
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: [
                  smallCard(),
                  const SizedBox(height: 8),
                  smallCard(),
                  const SizedBox(height: 8),
                  smallCard(),
                  const SizedBox(height: 8),
                  smallCard(),
                  const SizedBox(height: 8),
                  smallCard(),
                  const SizedBox(height: 8),
                  smallCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
