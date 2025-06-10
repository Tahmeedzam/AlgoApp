import 'package:algosapp/components/splashScreen.dart';
import 'package:algosapp/navigators/AdminBottomNav.dart';
import 'package:algosapp/navigators/BottomNav.dart';
import 'package:algosapp/pages/HomePage.dart';
import 'package:algosapp/pages/admin/AddAlgoPage.dart';
import 'package:algosapp/pages/admin/AddAlgoPage2.dart';
import 'package:algosapp/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.dark,
      // home: AdminBottomNav(),
      home: AddAlgoPage2(),
    );
  }
}
