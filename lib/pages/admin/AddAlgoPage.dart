import 'package:algosapp/components/customDropDown.dart';
import 'package:algosapp/components/customSnackBar.dart';
import 'package:algosapp/components/customTextField.dart';
import 'package:algosapp/components/label.dart';
import 'package:algosapp/components/loadingCircle.dart';
import 'package:algosapp/pages/admin/AddAlgoPage2.dart';
import 'package:algosapp/pages/shimmerPages/AddAlgoShimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class AddAlgoPage extends StatefulWidget {
  const AddAlgoPage({super.key});

  @override
  State<AddAlgoPage> createState() => _AddAlgoPageState();
}

class _AddAlgoPageState extends State<AddAlgoPage> {
  List<String> _categories = ['Select Category'];
  List<String> _catIds = [''];
  bool _loading = true;
  final _idCtrl = TextEditingController();
  final _numberCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String? _cat1;
  String? _cat2;
  String? _cat1Id;
  String? _cat2Id;

  @override
  void dispose() {
    // Always dispose controllers in a StatefulWidget
    _idCtrl.dispose();
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _numberCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('categories')
          .orderBy('name')
          .get();

      final names = <String>[];
      final ids = <String>[];

      for (var d in snap.docs) {
        final name = (d.data()['name'] ?? '').toString();
        if (name.isNotEmpty) {
          names.add(name);
          ids.add(d.id); // ← capture doc ID
        }
      }

      if (mounted) {
        setState(() {
          _categories = names;
          _catIds = ids;
          _loading = false;
        });
      }
    } catch (e) {
      debugPrint('Category load failed: $e');
      if (mounted) setState(() => _loading = false);
    }
  }

  Map<String, Object?> readyData() {
    final categories = [
      _cat1,
      _cat2,
    ].where((c) => c != null && c!.isNotEmpty).cast<String>().toList();

    // change Number field from text to Number
    final String raw = _numberCtrl.text.trim();
    final int? number = int.tryParse(raw);

    Map<String, Object?> algoData;

    return algoData = {
      'id': _idCtrl.text.trim(),
      'number': number,
      'name': _nameCtrl.text.trim(),
      'description': _descCtrl.text,
      if (categories.isNotEmpty) 'category': categories,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xff1A1A1A),
        title: const Text(
          'Add New Algo',
          style: TextStyle(color: Color(0xffE0E0E0), fontSize: 18),
        ),
      ),
      body: _loading ? const AddAlgoShimmer() : _formBody(),
    );
  }

  Widget _formBody() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Details:',
                style: TextStyle(color: Color(0xffE0E0E0), fontSize: 20),
              ),
            ),
            //TextFields
            CustomTextField(label: 'ID : *', controller: _idCtrl),
            const SizedBox(height: 15),
            CustomTextField(label: 'Number : *', controller: _numberCtrl),
            const SizedBox(height: 15),
            CustomTextField(label: 'Name : *', controller: _nameCtrl),
            const SizedBox(height: 28),

            customlabel('Category 1: *'),
            myCustomDropDown(
              value: _cat1,
              categories: _categories, // UI list
              onChanged: (v) {
                setState(() => _cat1 = v);
                final index = _categories.indexOf(v ?? '');
                final pickedId = index >= 0 ? _catIds[index] : null;
                debugPrint('User picked ‑ $v (id: $pickedId)');
                _cat1Id = pickedId; // store it for later
              },
            ),

            const SizedBox(height: 15),

            customlabel('Category 2:'),
            myCustomDropDown(
              value: _cat2,
              categories: _categories, // UI list
              onChanged: (v) {
                setState(() => _cat2 = v);
                final index = _categories.indexOf(v ?? '');
                final pickedId = index >= 0 ? _catIds[index] : null;
                debugPrint('User picked ‑ $v (id: $pickedId)');
                _cat2Id = pickedId; // store it for later
              },
            ),

            const SizedBox(height: 15),

            customlabel('Description : *'),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: _descCtrl,
                minLines: 1,
                maxLines: 8,
                style: const TextStyle(color: Color(0xffE0E0E0)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff1A1A1A),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffFFD300)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF606060),
                      width: 1.25,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildStickyNextButton(),
          ],
        ),
      ),
    );
    // );
  }

  Widget _buildStickyNextButton() {
    return SafeArea(
      // keeps it above gesture bar / notch
      child: Container(
        color: const Color(0xff0D0D0D), // optional background
        padding: const EdgeInsets.only(right: 8), // match your design
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () async {
                // Check if cat2 is empty or not
                final algoData = readyData();
                debugPrint('Ready to upload ➜ $algoData');

                //Show Loading screen
                showDialog(
                  context: context,
                  barrierDismissible: false, // user can’t close it
                  builder: (_) => LoadingCircle(),
                );

                // ─── save to Firestore under user‑defined doc ID ────
                try {
                  // todo: Uncomment this while inputting values to database
                  await FirebaseFirestore.instance
                      .collection('algorithms')
                      .doc(_idCtrl.text.trim()) // use the typed ID
                      .set(algoData);

                  await FirebaseFirestore.instance
                      .collection('categories')
                      .doc('${_cat1Id}')
                      .update({
                        'algoIncluded': FieldValue.arrayUnion([
                          _idCtrl.text.trim(),
                        ]),
                      });

                  if (_cat2Id != null) {
                    await FirebaseFirestore.instance
                        .collection('categories')
                        .doc('${_cat2Id}')
                        .update({
                          'algoIncluded': FieldValue.arrayUnion([
                            _idCtrl.text.trim(),
                          ]),
                        });
                  }

                  // closing Loading screen
                  if (context.mounted) Navigator.pop(context); // pop loader
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        content: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Data Saved',
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  }

                  nextPage();
                } catch (e) {
                  debugPrint('Error saving data: $e');

                  //closing splash screen
                  if (context.mounted) Navigator.pop(context); // pop loader
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        content: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Error: $e',
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff1A1A1A),
                    border: Border.all(
                      color: const Color(0xFF606060),
                      width: 1.25,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Next', style: TextStyle(color: Color(0xFfE0E0E0))),
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
      ),
    );
  }

  nextPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AddAlgoPage2(
          id: _idCtrl.text.trim(), // Pass your data here
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Fade + Slide from right
          final offsetAnimation =
              Tween<Offset>(
                begin: Offset(1.0, 0.0), // slide from right
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              );

          final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: fadeAnimation, child: child),
          );
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }
}
