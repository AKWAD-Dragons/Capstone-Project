// import 'dart:io';

// import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
// import 'dart:math';

// class LocationProvider {
//   Location _location = Location();

//   Future<bool> deviceIsInLocation(String location) async {
//     if(!(await grantLocation())){
//       return false;
//     }
//     LocationData locationData = await _location.getLocation();
//     List<Placemark> locationAddresses = await Geolocator()
//         .placemarkFromCoordinates(
//             locationData.latitude, locationData.longitude);

//     return locationAddresses[0].isoCountryCode == location;
//   }

//   Future<LocationData> getUserLocation() async {
//     if(!(await grantLocation())){
//      await getUserLocation();
//     }
//     LocationData locationData = await _location.getLocation();
//     if(locationData==null){
//       locationData = await getUserLocation();
//     }

//     return locationData;
//   }

//   Future<bool> grantLocation() async {
//     if (!(await _location.hasPermission())) {
//       bool granted = await _location.requestPermission();
//       if (!granted) return false;
//     }
//     if (!(await _location.serviceEnabled())){
//       bool ready = await _location.requestService();
//       if (!Platform.isIOS && ready == false) {
//         return false;
//       }
//     }
//     return true;
//   }

//   double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
//     var R = 6371; // Radius of the earth in km
//     var dLat = deg2rad(lat2 - lat1); // deg2rad below
//     var dLon = deg2rad(lon2 - lon1);
//     var a = sin(dLat / 2) * sin(dLat / 2) +
//         cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
//     var c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     var d = R * c; // Distance in km
//     return d;
//   }

//   double deg2rad(deg) {
//     return deg * (pi / 180);
//   }
// }
