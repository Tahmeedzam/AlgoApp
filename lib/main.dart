import 'package:algosapp/components/splashScreen.dart';
import 'package:algosapp/navigators/AdminBottomNav.dart';
import 'package:algosapp/pages/HomePage.dart';
import 'package:algosapp/pages/algoViewPage.dart';
import 'package:algosapp/pushAlgoToFirebase/pushAllAlgo.dart';
import 'package:algosapp/theme/theme.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();

    // Handle links when app is opened from background/terminated
    _appLinks.getInitialLink().then(_handleIncomingLink);

    // Handle links when app is already running
    _appLinks.uriLinkStream.listen(_handleIncomingLink);
  }

  void _handleIncomingLink(Uri? uri) {
    if (uri == null) return;

    if (uri.pathSegments.isNotEmpty) {
      final algoId = uri.pathSegments[0]; // first segment is the algoId
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AlgoViewPage(id: algoId)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Algo Vault',
      darkTheme: darkMode,
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => HomePage());
        }

        // Handle direct algoId links like "/1234"
        if (settings.name != null && settings.name!.startsWith('/')) {
          final algoId = settings.name!.substring(1); // remove the leading '/'
          if (algoId.isNotEmpty) {
            return MaterialPageRoute(builder: (_) => AlgoViewPage(id: algoId));
          }
        }

        return null; // unknown route
      },
    );
  }
}
