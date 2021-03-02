//import 'dart:html';
//import 'dart:html';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:clima/services/weather.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    print('hhhhh');
    getLocationData();
  }

  void getLocationData() async {
    print("I am here!");
    var weatherData = await weatherModel.getWeatherLocation();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xff0C0017),
        body: Center(
            child: SpinKitRing(
      color: Color(0xFFd60000),
      size: 50.0,
    )));
  }
}
