import 'package:flutter/material.dart';
import 'package:towghana/screens/customer_support.dart';
import 'package:towghana/screens/road_assitance.dart';
import 'package:towghana/screens/tow_my_car.dart';

class GridDashboard extends StatelessWidget {
  final Item item1 = new Item(
      count: 0,
      title: "Road side Assistance",
      subtitle: "Request for road-side assistance",
      event: "3 events",
      img: "assets/images/tow2.png");
  final Item item2 = new Item(
      count: 1,
      title: "Customer Support",
      subtitle: "Contact our customer representative",
      event: "3 events",
      img: "assets/images/customer_service.png");
  final Item item3 = new Item(
      count: 2,
      title: "Tow my Car",
      subtitle: "Request a towing service",
      event: "3 events",
      img: "assets/images/tow_ghana.png");

  @override
  Widget build(BuildContext context) {
    List<Item> myList = [item1, item2, item3];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: () => selectedItem(context, data.count),
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(color),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        data.img,
                        width: 80,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        data.subtitle,
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        data.event,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
            );
          }).toList()),
    );
  }
}

class Item {
  String title;
  String subtitle;
  String event;
  String img;
  int count;

  Item(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img,
      required this.count});
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();

  switch (index) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => RoadAssistance()));
      break;
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CustomerSupport()));
      break;
    case 2:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => TowCar()));
      break;
  }
}
