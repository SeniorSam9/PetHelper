import 'package:location/location.dart';

Future<Map<String, double>?> retrieveGPSLocation() async {
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  // Check if location services are enabled
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return {
        'latitude': 0,
        'longitude': 0,
      };
    }
  }

  // Check if location permission is granted
  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return {
        'latitude': 0,
        'longitude': 0,
      };
    }
  }

  // Get the current location
  LocationData currentLocation = await location.getLocation();
  return {
    'latitude': currentLocation.latitude!,
    'longitude': currentLocation.longitude!,
  };
}