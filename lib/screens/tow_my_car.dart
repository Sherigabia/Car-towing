import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as loc;
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class TowCar extends StatefulWidget {
  const TowCar({Key? key}) : super(key: key);

  @override
  _TowCarState createState() => _TowCarState();
}

class _TowCarState extends State<TowCar> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool loading = false;
  late double latitude;
  late double longitude;
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);

    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();

      var url = Uri.parse(
          'http://b8f9-159-223-46-111.ngrok.io/tow_ghana/api/user/addlocation');

      longitude = _locationResult.longitude!;
      latitude = _locationResult.latitude!;
      var data = {
        'userID': '2',
        'longitude': longitude.toString(),
        'latitude': latitude.toString()
      };
      var response = await http.post(url, body: data);
      var result = jsonDecode(response.body);
      print("DATA: $result");

      setState(() {
        latitude = _locationResult.latitude!;
        longitude = _locationResult.longitude!;
        loading = false;
        Fluttertoast.showToast(
            msg: 'Tow request Sent', toastLength: Toast.LENGTH_SHORT);

        // print("Longitude :  $longitude");
        // print("Latitude :  $latitude");
      });
    } catch (e) {
      print(e);
    }
  }

  Future getData() async {
    var url =
        'http://f07e-51-81-35-164.ngrok.io/flutter_User/api/user/read.php';
    var response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  Future<void> _listenToLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tow my Car")),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            _getLocation();
          }),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            loading
                ? CircularProgressIndicator()
                : ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 8.0)),
                    onPressed: () {
                      // _getLocation();
                      showDoneDialog();
                      setState(() {
                        loading = true;
                      });
                    },
                    icon: Icon(Icons.location_on),
                    label: Text("Make Request")),
          ])),
    );
  }

  void showDoneDialog() => showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('assets/images/Success.json',
                    repeat: false,
                    controller: controller, onLoaded: (composition) {
                  controller.forward();
                }),
                Text(
                  "Tow Request Sent",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16)
              ],
            ),
          ));
}
