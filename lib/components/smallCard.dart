import 'package:algosapp/pages/algoViewPage.dart';
import 'package:flutter/material.dart';

class smallCard extends StatefulWidget {
  final Color Cardcolor;
  final String CardName;
  final String CardCategoryName;
  final String CardId;

  const smallCard({
    super.key,
    required this.Cardcolor,
    required this.CardName,
    required this.CardCategoryName,
    required this.CardId,
  });

  @override
  State<smallCard> createState() => _smallCardState();
}

class _smallCardState extends State<smallCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 90,
        width: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          border: BoxBorder.fromLTRB(
            left: BorderSide(color: widget.Cardcolor, width: 14),
          ),

          color: Color(0xff1A1A1A),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      widget.CardName,
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xffE0E0E0),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.CardCategoryName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff7D7D7D),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.bookmark_outline, size: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  AlgoViewPage(id: widget.CardId),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                // Fade + Slide from right
                                final offsetAnimation =
                                    Tween<Offset>(
                                      begin: Offset(
                                        1.0,
                                        0.0,
                                      ), // slide from right
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
                          transitionDuration: Duration(
                            milliseconds: 400,
                          ), // Pass your data here
                        ),
                      );
                      print(widget.CardId);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff0D0D0D),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
