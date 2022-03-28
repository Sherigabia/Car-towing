import 'package:flutter/material.dart';
import 'package:towghana/screens/TowingMap.dart';

import 'package:towghana/screens/login.dart';
import 'package:towghana/screens/mainPage.dart';
import 'package:towghana/screens/newMain.dart';

import 'package:towghana/screens/salvage.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final name = "${user.lastname} ${user.firstname}";
    final email = '${user.email}';
    final urlImage = 'assets/images/logo.jpg';
    return Drawer(
        child: Material(
            color: Colors.blue,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/person.png",
                    ),
                    radius: 50,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text("${user.lastname} ${user.firstname}",
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                    Text("${user.email}",
                        style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 17,
                            color: Colors.white)),
                  ],
                ),
                // buildHeader(
                //     urlImage: urlImage,
                //     name: name,
                //     email: email,
                //     onClicked: () =>
                //         Navigator.of(context).push(MaterialPageRoute(
                //             builder: (context) => UserPage(
                //                   name: name,
                //                   urlImage: urlImage,
                //                 )
                //                 )
                //                 )
                //                 ),
                Container(
                    padding: padding,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Divider(color: Colors.white70),
                        const SizedBox(
                          height: 12,
                        ),
                        buildMenuItem(
                          text: 'HOME PAGE',
                          icon: Icons.house,
                          onClicked: () => selectedItem(context, 0),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'TOW CAR',
                          icon: Icons.agriculture,
                          onClicked: () => selectedItem(context, 1),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'SALVAGE CAR',
                          icon: Icons.car_repair,
                          onClicked: () => selectedItem(context, 2),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ))
              ],
            )));
  }

  Widget buildSearchField() {
    final color = Colors.white;
    return TextField(
        style: TextStyle(color: color),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            hintText: 'Search',
            hintStyle: TextStyle(color: color),
            prefixIcon: Icon(Icons.search, color: color),
            filled: true,
            fillColor: Colors.white12,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: color.withOpacity(0.7),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: color.withOpacity(0.7)))));
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
          onTap: onClicked,
          child: Container(
              padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(urlImage),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(width: 10),
                ],
              )));

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewPage()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TowMap()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SalvageScreen()));
        break;
    }
  }
}

class DialogFb1 extends StatelessWidget {
  const DialogFb1({Key? key}) : super(key: key);
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 25,
              child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/FlutterBricksLogo-Med.png?alt=media&token=7d03fedc-75b8-44d5-a4be-c1878de7ed52"),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("How are you doing?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 3.5,
            ),
            const Text("This is a sub text, use it to clarify",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w300)),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(text: "Great", onPressed: () {}),
                SimpleBtn1(
                  text: "Not bad",
                  onPressed: () {},
                  invertedColors: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  const SimpleBtn1(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      Key? key})
      : super(key: key);
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            alignment: Alignment.center,
            side: MaterialStateProperty.all(
                BorderSide(width: 1, color: primaryColor)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.only(right: 25, left: 25, top: 0, bottom: 0)),
            backgroundColor: MaterialStateProperty.all(
                invertedColors ? accentColor : primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: invertedColors ? primaryColor : accentColor, fontSize: 16),
        ));
  }
}
