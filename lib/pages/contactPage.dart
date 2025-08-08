import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Contact us",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Color(0xffE0E0E0),
            ),
          ),
        ),
        backgroundColor: const Color(0xff0D0D0D),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              height: 2,
              thickness: 3,
              color: Color.fromARGB(255, 37, 37, 37),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Meet the Developers: ",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Color(0xffE0E0E0),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.amber),
                      SizedBox(width: 5),
                      SelectableText(
                        "Tahmeed Zamindar",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: Color(0xffE0E0E0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 30),
                      InkWell(
                        child: Text(
                          "LinkedIn",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xffE0E0E0),
                          ),
                        ),
                        onTap: () {
                          launchUrlString(
                            'https://www.linkedin.com/in/tahmeedzamindar/',
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.amber),
                      SizedBox(width: 5),
                      SelectableText(
                        "Jayesh Wagh",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: Color(0xffE0E0E0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 30),
                      InkWell(
                        child: Text(
                          "LinkedIn",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xffE0E0E0),
                          ),
                        ),
                        onTap: () {
                          launchUrlString(
                            'https://www.linkedin.com/in/jayesh-wagh-7797a62a2/',
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.amber),
                      SizedBox(width: 5),
                      SelectableText(
                        "Vishhal Narkar",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: Color(0xffE0E0E0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 30),
                      InkWell(
                        child: Text(
                          "LinkedIn",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                            color: Color(0xffE0E0E0),
                          ),
                        ),
                        onTap: () {
                          launchUrlString(
                            'https://www.linkedin.com/in/vishhalnarkar/',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'For FeedBack: ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color: Color(0xffE0E0E0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 5),
                  SelectableText(
                    ": thezams.co@gmail.com",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Color(0xffE0E0E0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.rate_review_rounded),
                  SizedBox(width: 5),
                  InkWell(
                    child: Text(
                      ": Write a review",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: Color(0xffE0E0E0),
                      ),
                    ),
                    onTap: () {
                      launchUrlString(
                        'https://play.google.com/store/apps/details?id=com.algovault.app',
                      );
                    },
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
