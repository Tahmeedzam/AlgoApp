import 'package:algosapp/navigators/AdminBottomNav.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddAlgoShimmer extends StatelessWidget {
  const AddAlgoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0D0D0D),
        body: Shimmer.fromColors(
          baseColor: Color(0xff1A1A1A),
          highlightColor: Colors.grey.shade300,
          child: Column(
            children: [
              SizedBox(height: 20),
              //Details
              Center(
                child: Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 20,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 28),
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 20,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 28),
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 20,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 28),
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 28),
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
