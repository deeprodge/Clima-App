import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocation/geolocation.dart';

class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {
      Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
      print('Geolocator set');
//      Position position = await geolocator.getLastKnownPosition();
//      position = await geolocator.getCurrentPosition(
//          desiredAccuracy: LocationAccuracy.low);
      LocationResult result = await Geolocation.lastKnownLocation();

      print('position got');
      latitude = result.location.latitude;
      longitude = result.location.longitude;
      print("Got Coordinates");
      print(latitude);
    } catch (e) {
      print(e);
    }
  }
}
