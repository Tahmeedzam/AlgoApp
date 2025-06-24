import 'package:algosapp/components/bigCard.dart';
import 'package:algosapp/components/smallCard.dart';
import 'package:algosapp/components/splashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* ─── category caches ─────────────────────────────────────────── */

  final Map<String, Color> _colorByName = {}; // name → Color
  final Map<String, String> _catNames = {}; // id   → name
  bool _catsLoaded = false;
  bool _pageLoaded = false;
  late String id;

  /* ─── search state ────────────────────────────────────────────── */
  final TextEditingController _searchCtrl = TextEditingController(); // ★
  String _searchQuery = ''; // ★

  @override
  void initState() {
    super.initState();
    _pageLoaded ? SplashScreen() : _loadCategoryMeta();
  }

  @override
  void dispose() {
    _searchCtrl.dispose(); // ★
    super.dispose();
  }

  Future<void> _loadCategoryMeta() async {
    final snap = await FirebaseFirestore.instance
        .collection('categories')
        .get();

    for (final doc in snap.docs) {
      final data = doc.data();
      final hex = (data['color'] as String).replaceFirst('#', '');
      final color = Color(int.parse(hex)); // "#0xffAABBCC" → Color
      final name = (data['name'] ?? '').toString();

      _colorByName[name] = color;
      _catNames[doc.id] = name;
    }
    setState(() => _catsLoaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            'Algo-Verse',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Color(0xffE0E0E0),
              letterSpacing: 4,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /* ── horizontal big cards + search UI ───────────────── */
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: const [
                        bigCard(),
                        SizedBox(width: 8),
                        bigCard(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 🔍 Search bar
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl, // ★
                          onChanged: (value) => setState(() {
                            // ★ realtime
                            _searchQuery = value.trim();
                          }),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: const TextStyle(
                              color: Color(0xff7D7D7D),
                            ),
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

                  const SizedBox(height: 30),
                  const Text(
                    'Recommended:',
                    style: TextStyle(fontSize: 16, color: Color(0xff7D7D7D)),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),

            /* ── algorithms list (filtered in realtime) ─────────── */
            Expanded(
              child: !_catsLoaded
                  ? const Center(child: CircularProgressIndicator())
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('algorithms')
                          // .orderBy('times_viewed', descending: true)
                          .snapshots(),
                      builder: (context, snap) {
                        if (!snap.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        // ---- filter locally by search query (case-insensitive)
                        final query = _searchQuery.toLowerCase();
                        final docs = snap.data!.docs.where((doc) {
                          if (query.isEmpty) return true;
                          final name = (doc['name'] ?? '')
                              .toString()
                              .toLowerCase();
                          return name.contains(query);
                        }).toList();

                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          itemCount: docs.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (_, i) {
                            final data = docs[i].data() as Map<String, dynamic>;
                            final List<String> catNames =
                                (data['category'] as List?)?.cast<String>() ??
                                [];

                            Color cardColor = const Color(0xffFFD300);
                            if (catNames.isNotEmpty &&
                                _colorByName.containsKey(catNames.first)) {
                              cardColor = _colorByName[catNames.first]!;
                            }

                            final subTitle = catNames.join(', ');

                            // passing id to smallCard
                            id = data['id'];
                            return smallCard(
                              Cardcolor: cardColor,
                              CardName: data['name'] ?? 'Untitled',
                              CardCategoryName: subTitle,
                              CardId: id,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
