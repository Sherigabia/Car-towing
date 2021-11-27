import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:towghana/screens/home.dart';
import 'package:towghana/screens/login.dart';
import 'package:towghana/screens/onboarding.dart';
import 'package:towghana/screens/mainPage.dart';
import 'package:towghana/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tow Ghana App ',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: AnimatedSplashScreen(
          splash: Image.asset("assets/images/logo.jpeg"),
          nextScreen: OnboardingScreen(),
          splashTransition: SplashTransition.decoratedBoxTransition,
          backgroundColor: Colors.white,
          duration: 3000,
          splashIconSize: 100,
          curve: Curves.easeInCirc,
        ));
  }
}
