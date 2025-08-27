import 'package:algosapp/components/bigCard.dart';
import 'package:algosapp/components/smallCard.dart';
import 'package:algosapp/components/splashScreen.dart';
import 'package:algosapp/services/ad_helper.dart';
import 'package:algosapp/services/savedAlgoHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
  late BannerAd? _HomeScreenBannerAd;
  List<String> savedAlgos = [];
  List<String> _savedIds = [];

  /* ─── search state ────────────────────────────────────────────── */
  final TextEditingController _searchCtrl = TextEditingController(); // ★
  String _searchQuery = ''; // ★

  @override
  void initState() {
    super.initState();
    loadSavedAlgos().then((ids) {
      if (mounted) {
        setState(() {
          _savedIds = ids;
        });
      }
    });
    _HomeScreenBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          print('Failed to load: ${error.message}');
          ad.dispose();
        },
      ),
    );
    _HomeScreenBannerAd!.load();
    _pageLoaded ? SplashScreen() : _loadCategoryMeta();
  }

  @override
  void dispose() {
    _searchCtrl.dispose(); // ★
    _loadBookmarks();
    super.dispose();
  }

  void _loadBookmarks() async {
    savedAlgos = await loadSavedAlgos();
    if (mounted) {
      setState(() {
        // update UI
      });
    } // Refresh UI
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
            'Algo-Vault',
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
        child: Stack(
          children: [
            // if (_HomeScreenBannerAd != null)
            //   Align(
            //     alignment: Alignment.topCenter,
            //     child: Container(
            //       color: Colors.red,
            //       width: _HomeScreenBannerAd!.size.width.toDouble(),
            //       height: _HomeScreenBannerAd!.size.height.toDouble(),
            //       child: AdWidget(ad: _HomeScreenBannerAd!),
            //     ),
            // ),
            Column(
              children: [
                /* ── horizontal big cards + search UI ───────────────── */
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  // child: Icon(
                                  //   size: 15,
                                  //   Icons.search,
                                  //   color: Colors.grey.shade600,
                                  // ),
                                  child: Image.asset(
                                    'assets/icons/search.png',
                                    color: const Color.fromARGB(
                                      255,
                                      255,
                                      211,
                                      0,
                                    ),
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
                        ],
                      ),
                      SizedBox(height: 10),
                      if (_HomeScreenBannerAd != null)
                        SizedBox(
                          width: _HomeScreenBannerAd!.size.width.toDouble(),
                          height: _HomeScreenBannerAd!.size.height.toDouble(),
                          child: AdWidget(ad: _HomeScreenBannerAd!),
                        ),

                      const SizedBox(height: 30),
                      const Text(
                        'Recommended:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff7D7D7D),
                        ),
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
                              .orderBy('times_viewed', descending: true)
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              itemCount: docs.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (_, i) {
                                final data =
                                    docs[i].data() as Map<String, dynamic>;
                                final List<String> catNames =
                                    (data['category'] as List?)
                                        ?.cast<String>() ??
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
                                  isBookmarked: _savedIds.contains(id),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
