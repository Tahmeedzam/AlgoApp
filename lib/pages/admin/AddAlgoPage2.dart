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
          child: const Icon(Icons.add, color: Colors.black, size: 30),
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
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff0D0D0D),
                        border: Border.all(color: Color(0xffE0E0E0), width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(color: Color(0xffE0E0E0)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Color(0xFFFFD300), width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Next', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: Color(0xFFFFD300)),
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
