import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AlgoViewPage extends StatefulWidget {
  final String id;
  const AlgoViewPage({super.key, required this.id});

  @override
  State<AlgoViewPage> createState() => _AlgoViewPageState();
}

class _AlgoViewPageState extends State<AlgoViewPage> {
  late final String _id;
  late final DocumentReference<Map<String, dynamic>> _docRef;
  String? algoName;
  String? algoDescription;
  String? algoMainImage;
  List<String>? algoSlideshowImage;
  String? algoJavaCode;
  String? algoCppCode;
  String? algoPythonCode;
  bool dataFetched = false;

  @override
  void initState() {
    super.initState();
    _id = widget.id; // ✅ now works
    _docRef = FirebaseFirestore.instance.collection('algorithms').doc(_id); // ✅
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final docSnapshot = await _docRef.get(); // 1️⃣ single read
      if (!docSnapshot.exists) return;

      final data = docSnapshot.data(); // Map<String,dynamic>?
      if (data == null) return;

      if (mounted) {
        setState(() {
          // 2️⃣ trigger rebuild
          algoName = data['name'] as String?;
          algoDescription = data['description'] as String?;
          dataFetched = true;
        });
        print(algoDescription);
      }
    } catch (e, st) {
      debugPrint('fetchData() failed: $e\n$st'); // 4️⃣ error handling
    }
  }

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return dataFetched == (false)
        ? Container(
            color: Color(0xFF1A1A1A),
            child: Center(child: CircularProgressIndicator()),
          )
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF1A1A1A),
                title: Text(algoName!),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              backgroundColor: const Color(0xff0D0D0D),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 20),
                    // const SizedBox(height: 20),
                    Expanded(
                      child: PageView(
                        physics: BouncingScrollPhysics(),
                        // controller: _pageCtrl,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        children: [
                          descPage(algoDescription: algoDescription),
                          descPage(algoDescription: algoDescription),
                          descPage(algoDescription: algoDescription),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ─── Create Button ───────────────────────────────
              // bottomNavigationBar: _currentPage == 2
              //     ? Padding(
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 20,
              //           vertical: 16,
              //         ),
              //         child: ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor: const Color(0xFFFFD300),
              //             foregroundColor: const Color(0xff0D0D0D),
              //             minimumSize: const Size.fromHeight(50),
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(12),
              //             ),
              //           ),
              //           // onPressed: _handleCreate,
              //           onPressed: () {},
              //           child: const Text('Create', style: TextStyle(fontSize: 16)),
              //         ),
              //       )
              //     : Padding(
              //         padding: const EdgeInsets.only(bottom: 40),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Swipe",
              //               style: TextStyle(fontSize: 14, color: Color(0xffE0E0E0)),
              //             ),
              //             Icon(
              //               Icons.arrow_right_alt_rounded,
              //               color: Color(0xffE0E0E0),
              //             ),
              //           ],
              //         ),
              //       ),
            ),
          );
  }
}

class descPage extends StatelessWidget {
  final String? algoDescription;
  const descPage({Key? key, required this.algoDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollCtrl =
        ScrollController(); // one controller for Scrollbar + SCScroll

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Tabs ───────────────────────────────────────────────
        const SizedBox(height: 2),
        Container(
          color: const Color(0xFF1A1A1A),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Tab(text: 'Explanation', active: true),
              _Tab(text: 'Visualization'),
              _Tab(text: 'Code'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ── Card ───────────────────────────────────────────────
        Expanded(
          // ← gives the card (and later the scroll view) finite height
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF1A1A1A),
            ),
            child: Column(
              children: [
                // Image
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://res.cloudinary.com/daozctcil/image/upload/v1750173258/cpy0ffz4kj5aku7trr7w.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Scrollable description
                Expanded(
                  // ← bounds the SingleChildScrollView
                  child: Scrollbar(
                    controller: scrollCtrl,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: scrollCtrl,
                      padding: const EdgeInsets.fromLTRB(15, 10, 10, 16),
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        algoDescription ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff7D7D7D),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Simple tab label widget (optional)
class _Tab extends StatelessWidget {
  final String text;
  final bool active;
  const _Tab({required this.text, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: active ? const Color(0xffFFD300) : const Color(0xffE0E0E0),
      ),
    );
  }
}
