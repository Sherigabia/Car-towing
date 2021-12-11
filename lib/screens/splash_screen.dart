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
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/images/car.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Image.asset("assets/images/logo.jpeg"),
                Row(
                  children: [
                    Text(
                      "TOW",
                      style: TextStyle(color: Colors.orange),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text("GHANA")
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
