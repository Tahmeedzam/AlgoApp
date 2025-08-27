import 'package:algosapp/pages/codePage.dart';
import 'package:algosapp/services/ad_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  BannerAd? _HomeScreenBannerAd;

  @override
  void initState() {
    super.initState();
    _id = widget.id; // ✅ now works
    _docRef = FirebaseFirestore.instance.collection('algorithms').doc(_id); // ✅
    fetchData();
    getTimeViewed();
    _HomeScreenBannerAd = AdHelper.algoPageAd();
    _HomeScreenBannerAd!.load();
  }

  @override
  void dispose() {
    _HomeScreenBannerAd?.dispose();
    super.dispose();
  }

  Future<void> getTimeViewed() async {
    final docSnapshot = await _docRef.get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      await _docRef.update({'times_viewed': FieldValue.increment(1)});
    } else {
      print('Document does not exist');
    }
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
          algoMainImage = data['mainImage'] as String?;
          algoSlideshowImage = List<String>.from(data['slideshowImage'] ?? []);
          algoJavaCode = data['java'] as String?;
          algoCppCode = data['cpp'] as String?;
          algoPythonCode = data['python'] as String?;
          dataFetched = true;
        });
        print(algoSlideshowImage);
      }
    } catch (e, st) {
      debugPrint('fetchData() failed: $e\n$st'); // 4️⃣ error handling
    }
  }

  Future<void> shareAlgorithm({
    required BuildContext context,
    required String algoId,
    String? algoName,
  }) async {
    final link = 'https://algovault.netlify.app/$algoId';

    // Compute the origin rect for the share sheet (useful for iPad).
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    final Rect shareOrigin = box != null
        ? (box.localToGlobal(Offset.zero) & box.size)
        : const Rect.fromLTWH(0, 0, 1, 1);

    final params = ShareParams(
      text: 'Check out "${algoName ?? 'this algorithm'}" on AlgoVault: $link',
      subject: 'AlgoVault: ${algoName ?? ''}',
      sharePositionOrigin: shareOrigin,
    );

    try {
      // Use the instance API (non-deprecated)
      await SharePlus.instance.share(params);
    } catch (e) {
      // handle or log errors
      debugPrint('Share failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return dataFetched == (false)
        ? Container(
            color: Color(0xFF1A1A1A),
            child: Center(child: CircularProgressIndicator()),
          )
        : SafeArea(
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xFF1A1A1A),
                  title: Text(
                    algoName!,
                    style: TextStyle(color: Color(0xffE0E0E0)),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => shareAlgorithm(
                        algoId: _id,
                        algoName: algoName,
                        context: context,
                      ),
                      icon: Icon(Icons.share, color: Colors.grey.shade700),
                    ),
                  ],
                ),

                backgroundColor: const Color(0xff0D0D0D),
                bottomNavigationBar: _HomeScreenBannerAd != null
                    ? SizedBox(
                        width: _HomeScreenBannerAd!.size.width.toDouble(),
                        height: _HomeScreenBannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _HomeScreenBannerAd!),
                      )
                    : null,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      indicatorColor: Color(0xffFFD300),
                      tabs: [
                        Tab(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Explaination',
                              style: TextStyle(
                                color: Color(0xff7D7D7D),
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Visualization',
                              style: TextStyle(
                                color: Color(0xff7D7D7D),
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Code',
                              style: TextStyle(
                                color: Color(0xff7D7D7D),
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: TabBarView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          descPage(
                            algoDescription: algoDescription,
                            mainImage: algoMainImage,
                          ),
                          Visualizationpage(
                            algoSlideshowImage: algoSlideshowImage,
                          ),
                          codePage(
                            cppCode: algoCppCode,
                            javaCode: algoJavaCode,
                            pythonCode: algoPythonCode,
                          ),
                          // Container(child: Center(child: Text("Page"))),
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

class descPage extends StatelessWidget {
  final String? algoDescription;
  final String? mainImage;
  const descPage({
    Key? key,
    required this.algoDescription,
    required this.mainImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollCtrl =
        ScrollController(); // one controller for Scrollbar + SCScroll

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                      mainImage as String,
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
                      padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
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

class Visualizationpage extends StatefulWidget {
  final List<String>? algoSlideshowImage;
  const Visualizationpage({Key? key, required this.algoSlideshowImage})
    : super(key: key);

  @override
  State<Visualizationpage> createState() => _VisualizationpageState();
}

class _VisualizationpageState extends State<Visualizationpage> {
  // final CarouselController _carouselCtrl = CarouselController(); // ✅ correct
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.algoSlideshowImage ?? [];

    Widget buildImage(String? slideShow, int index) {
      if (slideShow == null || slideShow.isEmpty) {
        return const Center(child: Text("Slideshow not available"));
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            slideShow,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image),
          ),
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        images.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Text(
                    'Slideshow not available',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              )
            : Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: images.length,
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: 400,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        if (mounted) {
                          setState(() {
                            _currentPage = index;
                          });
                        }
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return buildImage(images[index], index);
                    },
                  ),
                  const SizedBox(height: 12),
                  AnimatedSmoothIndicator(
                    activeIndex: _currentPage,
                    count: images.length,
                    effect: WormEffect(
                      activeDotColor: Color(0xFFFFD300),
                      dotHeight: 12,
                      dotWidth: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1A1A1A),
                        ),
                        onPressed: () =>
                            buttonCarouselController.previousPage(),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(0xffE0E0E0),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1A1A1A),
                        ),
                        onPressed: () => buttonCarouselController.nextPage(),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xffE0E0E0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ],
    );
  }
}
