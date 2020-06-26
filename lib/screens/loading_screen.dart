import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}


void getLocation() async {
    Location location= Location();
   await location.getCurrentLocation();
   print(location.latitude);
   print(location.longitude);

}
void getData() async {
  http.Response response=await http.get(
      'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=439d4b804bc8187953eb36d2a8c26a02');

  if(response.statusCode==200){
    String data= response.body;
    double temp=jsonDecode(data)['main']['temp'];
    int condition=jsonDecode(data)['weather'][0]['id'];
    String cityName=jsonDecode(data)['name'];
    //String weatherCondition=jsonDecode(data)['weather'][0]['description'];

    print(temp);
  }
  else
    print(response.statusCode);

}
class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(

    );
  }
}
