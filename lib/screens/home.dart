//import 'package:carousel_slider/carousel_slider.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:towghana/screens/tow_my_car.dart';
//import 'package:towghana/model/user_model.dart';
//import 'package:towghana/screens/login.dart';
//import 'package:towghana/screens/maps.dart';
//import 'package:towghana/widgets/grid_dashboard.dart';
//import 'package:towghana/widgets/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final List<String> imgList = [
  'assets/images/tow2.png',
  'assets/images/customer_service.png',
  'assets/images/logo.png',
  'assets/images/tow_ghana.png',
  'assets/images/online_road.png',
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(crossAxisCount: 2, children: <Widget>[
        Card(
          shadowColor: Colors.black87,
          margin: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TowCar()));
            },
            splashColor: Colors.blueGrey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.agriculture, size: 70.0, color: Colors.amber),
                  Text(
                    "Tow My Car",
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.blueGrey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.car_repair, size: 70.0, color: Colors.green),
                  Text(
                    "Salvage My Car",
                    style: TextStyle(fontSize: 17.0),
                  )
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.blueGrey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_pin, size: 70.0, color: Colors.blue),
                  Text(
                    "New Icon",
                    style: TextStyle(fontSize: 17.0),
                  )
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.blueGrey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_pin, size: 70.0, color: Colors.blue),
                  Text(
                    "New Icon 2",
                    style: TextStyle(fontSize: 17.0),
                  )
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.blueGrey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_pin, size: 70.0, color: Colors.blue),
                  Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 17.0),
                  )
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.blueGrey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.library_books,
                      size: 70.0, color: Colors.deepOrange),
                  Text(
                    "Log",
                    style: TextStyle(fontSize: 17.0),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}


// User? user = FirebaseAuth.instance.currentUser;
// UserModel loggedInUser = UserModel();

// @override
// void initState() {
//   // TODO: implement initState
//   super.initState();

//   FirebaseFirestore.instance
//       .collection("users")
//       .doc(user!.uid)
//       .get()
//       .then((value) {
//     this.loggedInUser = UserModel.fromMap(value.data());
//     setState(() {});
//   });
// }

// @override
// Widget build(BuildContext context) {
//   final mapButton = Material(
//       elevation: 5,
//       color: Colors.greenAccent,
//       borderRadius: BorderRadius.circular(30),
//       child: MaterialButton(
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => MapScreen()));
//           },
//           padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
//           minWidth: MediaQuery.of(context).size.width,
//           child: Text("Get Map details",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold))));

//   return Scaffold(
//     drawer: NavigationDrawerWidget(),
//     appBar: AppBar(
//       title: Text(
//         "Tow Ghana",
//       ),
//       centerTitle: true,
//     ),
//     body: Center(
//       child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 150,
//                 child:
//                     Image.asset("assets/images/logo.jpeg", fit: BoxFit.contain),
//               ),
//               Text("Welcome Back",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               Text(
//                 "${loggedInUser.lastName} ${loggedInUser.firstName}",
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "${loggedInUser.email}",
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               SizedBox(height: 20),
//               mapButton,
//               SizedBox(height: 20),
//               ActionChip(
//                 label: Text("Logout"),
//                 onPressed: () {
//                   logout(context);
//                 },
//               )
//             ],
//           )),
//     ),
//   );
// }

// Future<void> logout(BuildContext context) async {
//   await FirebaseAuth.instance.signOut();
//   Navigator.of(context)
//       .pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
// }
