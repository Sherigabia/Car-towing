import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:towghana/screens/login.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        nextScreen: LoginScreen(),
        splashTransition: SplashTransition.decoratedBoxTransition,
        backgroundColor: Colors.white,
        duration: 3000,
        splashIconSize: 100,
        curve: Curves.easeInCirc,
      ),
    );
  }
}
