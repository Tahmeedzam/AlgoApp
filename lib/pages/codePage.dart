import 'package:algosapp/components/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/tomorrow-night.dart';

class codePage extends StatelessWidget {
  final String? javaCode;
  final String? pythonCode;
  final String? cppCode;
  const codePage({
    Key? key,
    required this.javaCode,
    required this.pythonCode,
    required this.cppCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            TabBar(
              indicatorColor: Color(0xffFFD300),
              tabs: [
                Tab(
                  child: Text(
                    'Java',
                    style: TextStyle(
                      color: Color(0xff7D7D7D),
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Python',
                    style: TextStyle(
                      color: Color(0xff7D7D7D),
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'C++',
                    style: TextStyle(
                      color: Color(0xff7D7D7D),
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  javaPage(javaCode: javaCode),
                  pythonPage(pythonCode: pythonCode),
                  cppPage(cppCode: cppCode),
                ],
              ),
            ),

            // ── Card ───────────────────────────────────────────────
          ],
        ),
      ),
    );
  }
}

class javaPage extends StatelessWidget {
  final String? javaCode;
  const javaPage({super.key, required this.javaCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A1A1A),
                ),
                icon: Icon(Icons.copy, color: Color(0xffFFD300)),
                label: Text(
                  "Copy Code",
                  style: TextStyle(color: Color(0xff7D7D7D)),
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: javaCode as String));
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar(
                      message: 'Code copied!',
                      bgColor: Color(0xFF1A1A1A),
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            // ← bounds the SingleChildScrollView
            child: SizedBox(
              height: 200,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: HighlightView(
                  javaCode as String,
                  language: 'java',
                  theme: monokaiSublimeTheme,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NatoSans',
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class pythonPage extends StatelessWidget {
  final String? pythonCode;
  const pythonPage({super.key, required this.pythonCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A1A1A),
                ),
                icon: Icon(Icons.copy, color: Color(0xffFFD300)),
                label: Text(
                  "Copy Code",
                  style: TextStyle(color: Color(0xff7D7D7D)),
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: pythonCode as String));
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar(
                      message: 'Code copied!',
                      bgColor: Color(0xFF1A1A1A),
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            // ← bounds the SingleChildScrollView
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: HighlightView(
                pythonCode as String,
                language: 'python',
                theme: monokaiSublimeTheme,
                textStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'NatoSans',
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class cppPage extends StatelessWidget {
  final String? cppCode;
  const cppPage({super.key, required this.cppCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A1A1A),
                ),
                icon: Icon(Icons.copy, color: Color(0xffFFD300)),
                label: Text(
                  "Copy Code",
                  style: TextStyle(color: Color(0xff7D7D7D)),
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: cppCode as String));
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar(
                      message: 'Code copied!',
                      bgColor: Color(0xFF1A1A1A),
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            // ← bounds the SingleChildScrollView
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: HighlightView(
                cppCode as String,
                language: 'cpp',
                theme: monokaiSublimeTheme,
                textStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'NatoSans',
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
