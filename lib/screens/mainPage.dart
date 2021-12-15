import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:towghana/screens/TowingMap.dart';
import 'package:towghana/screens/bottomSalvage.dart';
import 'package:towghana/screens/bottomTow.dart';
import 'package:towghana/screens/home.dart';
import 'package:towghana/screens/login.dart';
import 'package:towghana/screens/salvage.dart';

import 'package:towghana/screens/userProfile.dart';

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
    final screens = [UserProfile(), BottomTow(), HomeScreen(), BottomSalvage()];

    final items = <Widget>[
      Icon(Icons.person_outline, size: 30, color: Colors.white),
      Icon(Icons.agriculture_rounded, size: 30, color: Colors.white),
      Icon(Icons.home, size: 30, color: Colors.white),
      Icon(Icons.car_repair_rounded, size: 30, color: Colors.white),
      IconButton(
        onPressed: () {
//          exitDialog();
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

        bottomNavigationBar:
            BottomNavBarTransparentFb1(), //make sure to set extendBody: true; in the scaffold

        // CurvedNavigationBar(
        //   color: Colors.blue,
        //   backgroundColor: Colors.transparent,
        //   index: index,
        //   height: 60,
        //   animationDuration: Duration(milliseconds: 300),
        //   animationCurve: Curves.easeInOut,
        //   items: items,
        //   onTap: (index) => setState(() => this.index = index),
        // ),
      ),
    );
  }
}

class BottomNavBarTransparentFb1 extends StatefulWidget {
  const BottomNavBarTransparentFb1({Key? key}) : super(key: key);

  @override
  _BottomNavBarTransparentFb1State createState() =>
      _BottomNavBarTransparentFb1State();
}

class _BottomNavBarTransparentFb1State
    extends State<BottomNavBarTransparentFb1> {
  //- - - - - - - - - instructions - - - - - - - - - - - - - - - - - -
  // WARNING! MUST ADD extendBody: true; TO CONTAINING SCAFFOLD
  //
  // Instructions:
  //
  // add this widget to the bottomNavigationBar property of a Scaffold, along with
  // setting the extendBody parameter to true i.e:
  //
  // Scaffold(
  //  extendBody: true,
  //  bottomNavigationBar: BottomNavBarTransparentFb1()
  // )
  //
  // Properties such as color and height can be set by changing the properties at the top of the build method
  //
  // For help implementing this in a real app, watch https://www.youtube.com/watch?v=C0_3w0kd0nc. The style is different, but connecting it to navigation is the same.
  //
  //- - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - -

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = 56;

    final primaryColor = Colors.orange;
    final secondaryColor = Colors.black54;
    final accentColor = const Color(0xffffffff);
    final backgroundColor = Colors.black12.withOpacity(.2);

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

    return BottomAppBar(
      color: backgroundColor,
      elevation: 0,
      child: Stack(
        children: [
          Container(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavBarIcon(
                  text: "Home",
                  icon: Icons.home_outlined,
                  selected: true,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  },
                  defaultColor: secondaryColor,
                  selectedColor: primaryColor,
                ),
                NavBarIcon(
                  text: "Tow Car",
                  icon: Icons.agriculture_outlined,
                  selected: false,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TowMap()));
                  },
                  defaultColor: secondaryColor,
                  selectedColor: primaryColor,
                ),
                NavBarIcon(
                    text: "Salvage Car",
                    icon: Icons.car_repair_outlined,
                    selected: false,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalvageScreen()));
                    },
                    defaultColor: secondaryColor,
                    selectedColor: primaryColor),
                NavBarIcon(
                  text: "logout",
                  icon: Icons.logout_outlined,
                  selected: false,
                  onPressed: () {
                    exitDialog();
                  },
                  selectedColor: primaryColor,
                  defaultColor: secondaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed,
      this.selectedColor = const Color(0xffFF8527),
      this.defaultColor = Colors.black54})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final Color defaultColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? selectedColor : defaultColor,
          ),
        ),
      ],
    );
  }
}
