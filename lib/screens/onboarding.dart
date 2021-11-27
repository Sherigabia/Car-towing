import 'package:flutter/material.dart';
import 'package:towghana/screens/login.dart';
import 'package:towghana/screens/mainPage.dart';
import 'package:towghana/widgets/animated_indicator.dart';

const blue = Color(0xFF4781ff);
const KTitleStyle = TextStyle(
    fontSize: 30, color: Color(0xFF01002f), fontWeight: FontWeight.bold);
const KSubtitleStyle = TextStyle(
  fontSize: 22,
  color: Color(0xFF88869f),
);

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final pageController = new PageController(initialPage: 0);

    void nextPage() {
      pageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
                child: PageView(
          controller: pageController,
          children: [
            Slide(
              hero: Image.asset("assets/images/tow_ghana.png"),
              title: "Road Side Assistance",
              subtitle:
                  "Is your car stuck by the roadside? Do not worry, we provide road side assistance to get your vehicle back in no time",
              onNext: nextPage,
            ),
            Slide(
                hero: Image.asset("assets/images/customer_service.png"),
                title: "On Demand Car Towing",
                subtitle: "We provide on demand car towing services",
                onNext: nextPage),
            Slide(
                hero: Image.asset("assets/images/tow2.png"),
                title: "Vehicle Service",
                subtitle: "We provide vehicle services",
                onNext: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MainPage()));
                }),
          ],
        ))));
  }
}

class Slide extends StatelessWidget {
  final Widget hero;
  final String title, subtitle;
  final VoidCallback onNext;

  const Slide({
    Key? key,
    required this.hero,
    required this.title,
    required this.subtitle,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Expanded(
        child: hero,
      ),
      Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Text(title, style: KTitleStyle),
            SizedBox(height: 20),
            Text(subtitle, style: KSubtitleStyle, textAlign: TextAlign.center),
            SizedBox(height: 35),
            ProgressButton(
              onNext: onNext,
            ),
          ])),
      GestureDetector(
        onTap: onNext,
        child: Text(
          'Skip',
          style: KSubtitleStyle,
        ),
      ),
      SizedBox(
        height: 4,
      ),
    ]));
  }
}

class ProgressButton extends StatelessWidget {
  final VoidCallback onNext;
  const ProgressButton({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 75,
      child: Stack(
        children: [
          AnimatedIndicator(
              duration: const Duration(seconds: 10),
              size: 75,
              callback: onNext),
          Center(
              child: GestureDetector(
            child: Container(
                height: 60,
                width: 60,
                child: Center(
                    child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                )),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(99),
                )),
            onTap: onNext,
          ))
        ],
      ),
    );
  }
}
