import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/weather.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'city_screen.dart';
import 'package:clima/utilities/resuableCard.dart';
import 'package:weather_icons/weather_icons.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.LocationData);
  final LocationData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temp;
  int temperature;
  int condition;
  String cityName;
  String weatherCondition;
  IconData weatherIcon;
  WeatherModel weatherModel = WeatherModel();
  String weatherMessage;
  double feelsliketemp=0;
  int feelslike=0;

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        Alert(
                context: context,
                title: "Error!",
                desc: "Location Permission not provided!")
            .show();
        temperature = 0;
        weatherIcon = WeatherIcons.alien;
        weatherMessage = '';
        cityName = '';
        return;
      }
      temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherCondition = weatherData['weather'][0]['description'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature);
      feelsliketemp=weatherData['main']['feels_like'];
      feelslike=feelsliketemp.toInt();
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.LocationData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/location_background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          var weatherData =
                              await weatherModel.getWeatherLocation();
                          updateUI(weatherData);
                          Alert(
                                  context: context,
                                  title: "Updated!",
                                  desc: "Location Permission not provided!")
                              .show();
                        },

                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                        ),
                      ),
                      Text(
                        '$cityName',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          var typedName = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CityScreen();
                          }));
                          if (typedName != null) {
                            var weatherData =
                                await weatherModel.getCityWeather(typedName);
                            updateUI(weatherData);
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                  /*Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),*/
                  Expanded(
                    child: Column(
                      children: <Widget>[

                          SizedBox(
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Icon(
                                      weatherIcon,
                                      color: Colors.white,
                                      size:90,
                                    ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textBaseline: TextBaseline.alphabetic,
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  children: <Widget>[
                                    Text(
                                      '$temperature°',
                                      style: TextStyle(
                                          fontSize: 80,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text('C',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ],
                                ),
                                    Text(
                                      'Feels like $feelslike°c',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),


                              ],
                            ),

                          ),
                        Expanded(
                          child: ReusableCard(
                            colour: Colors.white,
                            
                          ),
                        ),
                        Expanded(
                          child: ReusableCard(
                            colour: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: ReusableCard(
                            colour: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}
