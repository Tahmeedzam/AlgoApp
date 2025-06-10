import 'package:flutter/material.dart';

class AddAlgoPage2 extends StatelessWidget {
  const AddAlgoPage2({super.key});

  Widget _imageUpload() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: Color(0xFFFFD300),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Color(0xFF0D0D0D), size: 50),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0D0D0D),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Media',
                  style: TextStyle(color: Color(0xffE0E0E0), fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Main Photo:',
                style: TextStyle(color: Color(0xffE0E0E0), fontSize: 16),
              ),
              _imageUpload(),
              const SizedBox(height: 10),
              const Text(
                'Slideshow Photos:',
                style: TextStyle(color: Color(0xffE0E0E0), fontSize: 16),
              ),
              _imageUpload(),
              _imageUpload(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff1A1A1A),
                        border: Border.all(
                          color: Color(0xff606060),
                          width: 1.25,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Color(0xff0D0D0D),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Back',
                            style: TextStyle(color: Color(0xffE0E0E0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
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
                          Text(
                            'Next',
                            style: TextStyle(color: Color(0xFfE0E0E0)),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xFFFFD300),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
