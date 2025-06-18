import 'package:algosapp/components/loadingCircle.dart';
import 'package:algosapp/navigators/AdminBottomNav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddAlgoPage3 extends StatefulWidget {
  const AddAlgoPage3({super.key, required this.id});
  final String id;

  @override
  State<AddAlgoPage3> createState() => _AddAlgoPage3State();
}

class _AddAlgoPage3State extends State<AddAlgoPage3> {
  final _pageCtrl = PageController();
  final _javaCode = TextEditingController();
  final _cppCode = TextEditingController();
  final _pythonCode = TextEditingController();

  int _currentPage = 0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Code :',
                style: TextStyle(fontSize: 20, color: Color(0xffE0E0E0)),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _CodePage(label: 'Java :', controller: _javaCode),
                  _CodePage(label: 'C++ :', controller: _cppCode),
                  _CodePage(label: 'Python :', controller: _pythonCode),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 40),
              child: GestureDetector(
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
            ),
          ],
        ),
      ),

      // ─── Create Button ───────────────────────────────
      bottomNavigationBar: _currentPage == 2
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD300),
                  foregroundColor: const Color(0xff0D0D0D),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _handleCreate,
                child: const Text('Create', style: TextStyle(fontSize: 16)),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Swipe",
                    style: TextStyle(fontSize: 14, color: Color(0xffE0E0E0)),
                  ),
                  Icon(Icons.arrow_right_alt_rounded, color: Color(0xffE0E0E0)),
                ],
              ),
            ),
    );
  }

  void _handleCreate() {
    showDialog(
      context: context,
      barrierDismissible: false, // user can’t close it
      builder: (_) => LoadingCircle(),
    );

    final java = _javaCode.text.trim();
    final cpp = _cppCode.text.trim();
    final python = _pythonCode.text.trim();

    // Print for now – replace with your Firestore code
    FirebaseFirestore.instance
        .collection('algorithms')
        .doc('${widget.id}')
        .update({
          'java': java,
          'cpp': cpp,
          'python': python,
          'times_viewed': 0,
        });
    if (context.mounted) Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminBottomNav()),
    );
  }
}

// ────────────────────────────────────────────────

class _CodePage extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _CodePage({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Color(0xffE0E0E0)),
          ),
          const SizedBox(height: 12),
          Container(
            height: 600,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF606060), width: 1.5),
            ),
            child: TextField(
              controller: controller,
              maxLines: null,
              expands: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter your code here...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
