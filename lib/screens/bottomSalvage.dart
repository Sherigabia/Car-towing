import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:towghana/screens/login.dart';

class BottomSalvage extends StatefulWidget {
  const BottomSalvage({Key? key}) : super(key: key);

  @override
  _BottomSalvageState createState() => _BottomSalvageState();
}

String address = '';

class _BottomSalvageState extends State<BottomSalvage>
    with SingleTickerProviderStateMixin {
  bool requestSent = false;
  static const double fabHeightClosed = 116.0;
  double fabHeight = fabHeightClosed;
  late AnimationController controller;
  bool loading = false;
  late double latitude;
  late double longitude;

  final loc.Location location = loc.Location();

  StreamSubscription<loc.LocationData>? _locationSubscription;
  var _initialCameraPosition =
      CameraPosition(target: LatLng(5.614818, -0.205874), zoom: 11.5);

  late GoogleMapController _googleMapController;

  late GoogleMapController newGoogleMapController;

  late Position currentPosition;

  var geoLocator = Geolocator();

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latlngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latlngPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  final panelController = PanelController();
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
    _googleMapController.dispose();
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

      var url = Uri.parse('https://towghana.com/tg/api/user/addlocation');
      //  var url = Uri.parse(
      //    'http://c540-154-160-11-165.ngrok.io/tow_ghana/api/user/addlocation');

      longitude = _locationResult.longitude!;
      latitude = _locationResult.latitude!;
      var data = {
        'userID': user.userId,
        'longitude': longitude.toString(),
        'latitude': latitude.toString(),
        'address': address
      };
      var response = await http.post(url, body: data);
      var result = jsonDecode(response.body);
      print("DATA: $result");
      GetAddressFromLatLong(latitude, longitude);
      setState(() {
        latitude = _locationResult.latitude!;
        longitude = _locationResult.longitude!;
        loading = false;
        _initialCameraPosition =
            CameraPosition(target: LatLng(latitude, longitude), zoom: 11.5);

        Fluttertoast.showToast(
            msg: 'Tow request Sent', toastLength: Toast.LENGTH_SHORT);

        // print("Longitude :  $longitude");
        // print("Latitude :  $latitude");
      });
      showDoneDialog();
    } catch (e) {
      print(e);
    }
  }

  //Get address from longitude and latitude
  Future<void> GetAddressFromLatLong(latitude, longitude) async {
    List<Placemark> placeMark =
        await placemarkFromCoordinates(latitude, longitude);
    print(placeMark);

    Placemark place = placeMark[0];
    setState(() {
      address =
          '${place.street} - ${place.subAdministrativeArea} - ${place.locality}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.5;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        SlidingUpPanel(
          onPanelSlide: (position) => setState(() {
            final panelMaxScrollExtent = panelHeightOpen - panelHeightClosed;

            fabHeight = position * panelMaxScrollExtent + fabHeightClosed;
          }),
          controller: panelController,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          parallaxEnabled: true,
          parallaxOffset: .5,
          minHeight: panelHeightClosed,
          maxHeight: panelHeightOpen,
          panelBuilder: (controller) => PanelWidget(
              panelController: panelController, controller: controller),
          body: Container(
            child: Stack(
              children: [
                GoogleMap(
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: _initialCameraPosition,
                    onMapCreated: (controller) {
                      _googleMapController = controller;
                      newGoogleMapController = controller;
                      locatePosition();
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8.0)),
                      onPressed: () {
                        _getLocation();
                        locatePosition();
                        setState(() {
                          loading = true;
                        });
                      },
                      icon: Icon(Icons.location_on),
                      label: Text("Make Request")),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: fabHeight,
          child: FloatingActionButton(
            onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(_initialCameraPosition)),
            child: Icon(Icons.center_focus_strong),
          ),
        ),
      ]),
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
                    height: 100,
                    width: 100,
                    controller: controller, onLoaded: (composition) {
                  controller.forward();
                }),
                Text(
                  "Salvage Request Sent",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your Location: $address",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ));
}

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;
  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) => ListView(
          padding: EdgeInsets.zero,
          controller: widget.controller,
          children: [
            SizedBox(height: 16),
            buildAboutText(),
            SizedBox(height: 24),
          ]);

  Widget buildDragHandle() => GestureDetector(
        child: Center(
          child: Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300]),
          ),
        ),
        onTap: togglePanel,
      );

  void togglePanel() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();

  Widget buildAboutText() => Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            buildDragHandle(),
            SizedBox(height: 12),
            Text(
              "Track Request",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 12,
            ),
            address.isEmpty
                ? Text(
                    "Content not available",
                    style: TextStyle(color: Colors.red),
                  )
                : Stepper(
                    controlsBuilder: (context, ControlsDetails) {
                      return SizedBox();
                    },
                    steps: [
                      Step(
                          title: Text(
                            "SALVAGE REQUEST SENT",
                            style: TextStyle(color: Colors.green[900]),
                          ),
                          content: Column(children: [
                            address.isEmpty
                                ? Text('No address available')
                                : Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.blue),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "$address",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[900]),
                                        ),
                                      ),
                                    ],
                                  )
                          ]),
                          subtitle: Text("Location",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900])),
                          isActive: true,
                          state: StepState.complete),
                      Step(
                          title: Text("PROCESSING REQUEST",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          content: Text(""),
                          subtitle: Text(
                              "processing your request for a salvage car service",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          isActive: true,
                          state: StepState.complete),
                      Step(
                          title: Text("TOW CAR DISPATCHED",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          content: Text(""),
                          subtitle: Text(
                              "A tow Car has been dispatched to your location",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          isActive: true,
                          state: StepState.complete),
                    ],
                    currentStep: _index,
                    onStepTapped: (index) {},
                  )
          ],
        ),
      );
}
