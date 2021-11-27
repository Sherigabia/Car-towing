import 'package:flutter/material.dart';
import 'package:towghana/screens/customer_support.dart';
import 'package:towghana/screens/road_assitance.dart';
import 'package:towghana/screens/tow_my_car.dart';

import 'package:towghana/screens/user.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final name = 'Username';
    final email = 'username@gmail.com';
    final urlImage = 'assets/images/logo.jpg';
    return Drawer(
        child: Material(
            color: Colors.blue,
            child: ListView(
              children: <Widget>[
                buildHeader(
                    urlImage: urlImage,
                    name: name,
                    email: email,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserPage(
                                  name: name,
                                  urlImage: urlImage,
                                )))),
                Container(
                    padding: padding,
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        const SizedBox(
                          height: 12,
                        ),
                        Divider(color: Colors.white70),
                        const SizedBox(
                          height: 12,
                        ),
                        buildMenuItem(
                          text: 'Home Page',
                          icon: Icons.house_outlined,
                          onClicked: () => selectedItem(context, 0),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Tow My Car',
                          icon: Icons.car_repair_outlined,
                          onClicked: () => selectedItem(context, 1),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Customer Service',
                          icon: Icons.headphones_outlined,
                          onClicked: () => selectedItem(context, 2),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'RoadSide Assistance',
                          icon: Icons.airline_seat_recline_normal_rounded,
                          onClicked: () => selectedItem(context, 3),
                        ),
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
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ))
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
            .push(MaterialPageRoute(builder: (context) => TowCar()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CustomerSupport()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RoadAssistance()));
        break;
    }
  }
}
