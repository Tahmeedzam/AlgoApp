import 'package:algosapp/components/splashScreen.dart';
import 'package:algosapp/navigators/AdminBottomNav.dart';
import 'package:algosapp/pushAlgoToFirebase/pushAllAlgo.dart';
import 'package:algosapp/theme/theme.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  await dotenv.load();
  MobileAds.instance.initialize();
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
      title: 'Algo Vault',
      darkTheme: darkMode,
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}
