import 'dart:async';

import 'package:flutter/material.dart';
import 'package:towghana/screens/onboarding.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(milliseconds: 400),
        () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen()))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
