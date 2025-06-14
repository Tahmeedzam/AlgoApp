import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddAlgoPage2 extends StatefulWidget {
  const AddAlgoPage2({super.key, required this.id});
  final String id;

  @override
  State<AddAlgoPage2> createState() => _AddAlgoPage2State();
}

class _AddAlgoPage2State extends State<AddAlgoPage2> {
  File? _mainImageFile;
  final List<File> _slideshowImages = [];
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    String id = widget.id;
    debugPrint("ID = $id");
  }

  Widget _uploadImageTile({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }

  Future<File?> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    return pickedFile == null ? null : File(pickedFile.path);
  }

  Future<void> _pickSlideshowImage() async {
    final file = await _pickImage(ImageSource.gallery);
    if (file != null) {
      setState(() => _slideshowImages.add(file));
    }
    print(_slideshowImages);
  }

  Future<void> _selectMainImage() async {
    final file = await _pickImage(ImageSource.gallery);
    if (file != null) {
      setState(() => _mainImageFile = file);
    }
    print(file.toString().trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Media :',
                  style: TextStyle(color: Color(0xffE0E0E0), fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Main Photo:',
                style: TextStyle(color: Color(0xffE0E0E0), fontSize: 16),
              ),
              const SizedBox(height: 10),
              _mainImageFile == null
                  ? _uploadImageTile(onTap: _selectMainImage)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        _mainImageFile!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(height: 20),
              const Text(
                'Slideshow Photos:',
                style: TextStyle(color: Color(0xffE0E0E0), fontSize: 16),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  for (final img in _slideshowImages)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          img,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  _uploadImageTile(onTap: _pickSlideshowImage),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 10,
          bottom: 70,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff1A1A1A),
                  border: Border.all(
                    color: const Color(0xff606060),
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color(0xff606060),
                    ),
                    SizedBox(width: 8),
                    Text('Back', style: TextStyle(color: Color(0xffE0E0E0))),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Next button logic
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff1A1A1A),
                  border: Border.all(
                    color: const Color(0xff606060),
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Next', style: TextStyle(color: Color(0xffE0E0E0))),
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
      ),
    );
  }
}
