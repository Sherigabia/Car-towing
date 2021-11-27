import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:towghana/screens/home.dart';
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

  @override
  Widget build(BuildContext context) {
    final screens = [UserProfile(), Transactions(), HomeScreen(), MapScreen()];

    final items = <Widget>[
      Icon(Icons.person_outline, size: 30, color: Colors.white),
      Icon(Icons.my_library_books, size: 30, color: Colors.white),
      Icon(Icons.home, size: 30, color: Colors.white),
      Icon(Icons.add_location_alt_outlined, size: 30, color: Colors.white),
      Icon(Icons.logout, size: 30, color: Colors.white),
    ];

    return Scaffold(
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
    );
  }
}
