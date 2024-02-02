import 'package:flutter/material.dart';
import 'package:my_learn_app/Controllers/onboarding_controller.dart';
import 'package:my_learn_app/Providers/favourite_provider.dart';
import 'package:my_learn_app/Views/onboarding_page.dart';
import 'package:my_learn_app/Views/home_page.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controller = OnboardingController();

  bool _showOnboardingScreen = true;

  @override
  void initState() {
    super.initState();

    _controller.checkOnboardingStatus().then((value) {
      setState(() {
        _showOnboardingScreen = value;
      });
      print('#### Check isFirstUser: $_showOnboardingScreen');
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavouriteItemProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inspira App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.lobsterTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: !_showOnboardingScreen ? HomePage() : OnboardingPage(),
      ),
    );
  }
}
