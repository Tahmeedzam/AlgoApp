import 'package:algosapp/components/loadingCircle.dart';
import 'package:algosapp/components/splashScreen.dart';
import 'package:algosapp/pushAlgoToFirebase/pushAllAlgo.dart';
import 'package:algosapp/navigators/AdminBottomNav.dart';
import 'package:algosapp/navigators/BottomNav.dart';
import 'package:algosapp/pages/HomePage.dart';
import 'package:algosapp/pages/admin/AddAlgoPage.dart';
import 'package:algosapp/pages/admin/AddAlgoPage2.dart';
import 'package:algosapp/pages/algoViewPage.dart';
import 'package:algosapp/pages/shimmerPages/AddAlgoShimmer.dart';
import 'package:algosapp/services/cloudinaryService.dart';
import 'package:algosapp/theme/theme.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
      // theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.dark,
      // theme: ThemeData().copyWith(
      //   textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      // ),
      // home: AdminBottomNav(),
      home: SplashScreen(),
      // home: pushAllAlgo(),
      // home: AddAlgoShimmer(),
      // home: AlgoViewPage(id: 'bubble_sort'),
    );
  }
}
