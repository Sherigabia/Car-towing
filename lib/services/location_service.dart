// import 'dart:async';
// import 'package:location/location.dart';
// import 'package:towghana/datamodels/userLocation.dart';

// class LocationService {
//   //Current location
//   late UserLocation _currentLocation;

//   Location location = Location();

//   //Continues Location updates
//   StreamController<UserLocation> _locationController =
//       StreamController<UserLocation>();

//   Stream<UserLocation> get locationStream => _locationController.stream;

//   LocationService() {
//     // Request permission to use location
//     location.requestPermission().then((granted) {
//       if (granted) {
//         // If granted listen to the onLocationChanged stream and emit over our controller
//         location.onLocationChanged().listen((locationData) {
//           if (locationData != null) {
//             _locationController.add(UserLocation(
//               latitude: locationData.latitude,
//               longitude: locationData.longitude,
//             ));
//           }
//         });
//       }
//     });
//   }



//   Future<UserLocation> getLocation() async {
//     try {
//       var userLocation = await location.getLocation();
//       _currentLocation = UserLocation(
//           latitude: userLocation.latitude!, longitude: userLocation.longitude!);
//     } catch (e) {
//       print("Could not get Location $e");
//     }

//     return _currentLocation;
//   }
// }
