import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    getLocation();
  }
  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    if (response.statusCode == 200) {
      String data = response.body;
      double tempInK = jsonDecode(data)['main']['temp'];
      double temp=((tempInK-32)*5)/9;
      int condition = jsonDecode(data)['weather'][0]['id'];
      String cityName = jsonDecode(data)['name'];
      String weatherCondition = jsonDecode(data)['weather'][0]['description'];

      print(temp);
      print(condition);
      print(cityName);
      print(weatherCondition);
    }
    else
      print(response.statusCode);
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(

    );
  }
}
