import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TowCar extends StatefulWidget {
  const TowCar({Key? key}) : super(key: key);

  @override
  _TowCarState createState() => _TowCarState();
}

class _TowCarState extends State<TowCar> {
  Future getData() async {
    var url = 'http://192.168.2.6:8000/flutter_User/api/user/read.php';
    var response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Tow my Car")),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
            ),
            onPressed: () {}),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListView.builder(itemBuilder: (context, index) {
                      List list = snapshot.data as List;
                      return ListTile(title: Text(list[index]['firstname']));
                    })
                  : CircularProgressIndicator();
            }));
  }
}
