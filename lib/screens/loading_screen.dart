//import 'dart:html';
//import 'dart:html';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';


const apiKey='549e1e365cc693bebbe0acf78c74f729';


class LoadingScreen extends StatefulWidget {


  @override
  _LoadingScreenState createState() => _LoadingScreenState();

}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }
  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkhelper=NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    var weatherData=await networkhelper.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context){return LocationScreen(weatherData);}));

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child:SpinKitRing(
      color: Colors.white,
        size: 50.0,
      )
      )

    );
  }
}
