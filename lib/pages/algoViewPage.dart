import 'package:algosapp/pages/codePage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                ),
                backgroundColor: const Color(0xff0D0D0D),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      indicatorColor: Color(0xffFFD300),
                      tabs: [
                        Tab(
                          child: Text(
                            'Explaination',
                            style: TextStyle(
                              color: Color(0xff7D7D7D),
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Visualization',
                            style: TextStyle(
                              color: Color(0xff7D7D7D),
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Code',
                            style: TextStyle(
                              color: Color(0xff7D7D7D),
                              fontFamily: 'Poppins',
                              fontSize: 16,
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
        return const Center(child: Text("No image"));
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
        CarouselSlider.builder(
          itemCount: images.length,
          carouselController: buttonCarouselController, // ✅ correct
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
              onPressed: () => buttonCarouselController.previousPage(),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xffE0E0E0),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A1A1A),
              ),
              onPressed: () => buttonCarouselController.nextPage(),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xffE0E0E0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
