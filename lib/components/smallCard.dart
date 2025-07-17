import 'dart:io';
import 'package:algosapp/services/ad_helper.dart';
import 'package:bounce/bounce.dart';
import 'package:algosapp/services/savedAlgoHelper.dart';
import 'package:flutter/material.dart';
import 'package:algosapp/pages/algoViewPage.dart';
import 'package:path_provider/path_provider.dart';

class smallCard extends StatefulWidget {
  final Color Cardcolor;
  final String CardName;
  final String CardCategoryName;
  final String CardId;
  final bool isBookmarked;

  const smallCard({
    super.key,
    required this.Cardcolor,
    required this.CardName,
    required this.CardCategoryName,
    required this.CardId,
    required this.isBookmarked,
  });

  @override
  State<smallCard> createState() => _smallCardState();
}

class _smallCardState extends State<smallCard> {
  late bool _bookmarked;

  @override
  void initState() {
    super.initState();
    _bookmarked = widget.isBookmarked;
  }

  void _toggleBookmark() async {
    setState(() {
      _bookmarked = !_bookmarked;
    });

    if (_bookmarked) {
      await saveAlgo(widget.CardId);
    } else {
      await removeAlgo(widget.CardId);
    }
  }

  Future<void> saveAlgo(String id) async {
    final file = await _getLocalFile();
    final existing = await file.readAsString().catchError((_) => '');
    if (!existing.contains(id)) {
      await file.writeAsString('$existing$id\n');
    }
  }

  Future<File> _getLocalFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/saved_algos.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Bounce(
      tilt: false,
      onTap: () {
        AdHelper.handleAlgoClickWithAd(() {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, animation, __) =>
                  AlgoViewPage(id: widget.CardId),
              transitionsBuilder: (_, animation, __, child) {
                final offsetAnimation =
                    Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    );

                final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
                    .animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    );

                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(opacity: fadeAnimation, child: child),
                );
              },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        });
      },

      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          height: 90,
          width: 450,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            border: Border(
              left: BorderSide(color: widget.Cardcolor, width: 14),
            ),
            color: const Color(0xff1A1A1A),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: name & category
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.CardName,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Color(0xffE0E0E0),
                          fontFamily: 'Poppins',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.CardCategoryName,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff7D7D7D),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Right side: bookmark + learn button
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // GestureDetector(
                    //   onTap: () async {
                    //     await saveAlgo(widget.CardId);
                    //     setState(() {
                    //       _bookmarked = true;
                    //     });
                    //   },
                    //   child: Icon(
                    //     _bookmarked ? Icons.bookmark : Icons.bookmark_outline,
                    //     size: 20,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (_, animation, __) =>
                                AlgoViewPage(id: widget.CardId),
                            transitionsBuilder: (_, animation, __, child) {
                              final offsetAnimation =
                                  Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut,
                                    ),
                                  );

                              final fadeAnimation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut,
                                    ),
                                  );

                              return SlideTransition(
                                position: offsetAnimation,
                                child: FadeTransition(
                                  opacity: fadeAnimation,
                                  child: child,
                                ),
                              );
                            },
                            transitionDuration: const Duration(
                              milliseconds: 400,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff0D0D0D),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Text(
                              "Learn",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 20,
                              color: Color(0xffFFD300),
                            ),
                          ],
                        ),
                      ),
                    ),
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
