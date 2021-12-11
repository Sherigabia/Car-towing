import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:towghana/screens/home.dart';
import 'package:towghana/screens/login.dart';
import 'package:towghana/screens/maps.dart';
import 'package:towghana/screens/transactions.dart';
import 'package:towghana/screens/userProfile.dart';
import 'package:towghana/screens/tow_my_car.dart';

import 'package:towghana/widgets/navigation_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 2;

  DateTime press_back = DateTime.now();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screens = [UserProfile(), Transactions(), HomeScreen(), MapScreen()];

    Future exitDialog() {
      return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                  title: Text("Are you Sure"),
                  content: Text("you want to exit the app?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      },
                      child: Text("Exit"),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("Cancel"))
                  ]));
    }

    final items = <Widget>[
      Icon(Icons.person_outline, size: 30, color: Colors.white),
      Icon(Icons.agriculture_rounded, size: 30, color: Colors.white),
      Icon(Icons.home, size: 30, color: Colors.white),
      Icon(Icons.car_repair_rounded, size: 30, color: Colors.white),
      IconButton(
        onPressed: () {
          exitDialog();
        },
        icon: Icon(
          Icons.logout,
          size: 30,
          color: Colors.white,
        ),
      )
    ];

    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(press_back);
        final cantExit = timegap >= Duration(seconds: 2);
        press_back = DateTime.now();
        if (cantExit) {
          final snack = SnackBar(
              content: Text("Press Back Button again to Exit App"),
              duration: Duration(seconds: 2));

          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        extendBody: true,
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(" Tow Ghana"),
          centerTitle: true,
        ),
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.blue,
          backgroundColor: Colors.transparent,
          index: index,
          height: 60,
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          items: items,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
