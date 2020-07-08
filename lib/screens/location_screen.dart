import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/weather.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'city_screen.dart';
import 'package:clima/utilities/resuableCard.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  double feelsliketemp = 0;
  int feelslike = 0;
  int minTemp=0;
  double minTempDou=0;
  double maxTempDou=0.0;
  int maxTemp=0;
  double humidity=0;
  double windSpeed=0;
  double windDir=0;
  double clouds=0;


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
      feelsliketemp = weatherData['main']['feels_like']+0.0;
      feelslike = feelsliketemp.toInt();
      minTempDou= weatherData['main']['temp_min']+0.0;
      minTemp=minTempDou.toInt();
      maxTempDou= weatherData['main']['temp_max']+0.0;
      maxTemp=maxTempDou.toInt();
      humidity=weatherData['main']['humidity']+0.0;
      windSpeed=weatherData['wind']['speed']+0.0;
      windDir=weatherData['wind']['deg']+0.0;
      clouds=weatherData['clouds']['all']+0.0;
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
      backgroundColor: Color(0xff0C0017),
        body: Container(
            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage('images/location_background.jpg'),
//                fit: BoxFit.cover,
//                colorFilter: ColorFilter.mode(
//                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
//              ),
            ),
            constraints: BoxConstraints.expand(),
            child: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            color: kCardColour
                        ),
                      ),
                      Text(
                        '$cityName',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Oswald",
                          color: kTempTextIcon
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
                            color: kCardColour
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: 50,
                    color: kTempTextIcon,
                  ),
                  SizedBox(
                    height: 50,
                  ),
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
                                color: Color(0xFFd60000),
                                size: 90,
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
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Oswald",
                                      color: kTempTextIcon
                                    ),
                                  ),
                                  Text(
                                    'C',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Oswald",
                                      color: Color(0xFFd60000),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Feels like $feelslike°c',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Oswald",
                                  color: kTempTextIcon.withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 97,
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ReusableCard(
                                  cardChild: MinMax('Minimum',minTemp),
                                ),
                              ),

                              Expanded(
                                child: ReusableCard(
                                  cardChild: MinMax('Maximum', maxTemp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ReusableCard(
                            cardChild: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    MisDetails(
                                        humidity,
                                        WeatherIcons.humidity,
                                        '%',
                                    ),
                                    MisDetails(
                                      clouds,
                                      WeatherIcons.cloud,
                                      '%'
                                    )
                                  ],
                                ),


                                Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    MisDetails(
                                        windSpeed,
                                        WeatherIcons.strong_wind,
                                        'M/s'
                                    ),
                                    MisDetails(
                                      windDir,
                                      WeatherIcons.wind_direction,
                                      'Deg',
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ]))));
  }
}

class MisDetails extends StatelessWidget {
  MisDetails(
      this.measures,
      this.icon,
      this.unit
  );

  final double measures;
  final IconData icon;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: <Widget>[
        Icon(icon),
        SizedBox(
          width: 15,
        ),
        Text(
          '$measures ',
          style: TextStyle(
            fontFamily: 'Oswald',
            fontSize: 25,
          ),
        ),
        Text('$unit',
          style: TextStyle(
            fontFamily: "Oswald",
            color:Color(0xFFd60000) ,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),)
      ],
    );
  }
}

class MinMax extends StatelessWidget {
  MinMax(this.cond,this.temp);
  String cond;
  int temp;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: cent,
      children: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: <Widget>[
            Text(
              '$cond: ',
              style: TextStyle(
                fontFamily: "Oswald",

                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text('$temp°',
              style: TextStyle(
                fontFamily: "Oswald",

                fontSize: 27,
                fontWeight: FontWeight.w400,
              ),),
            Text('c',
              style: TextStyle(
                fontFamily: "Oswald",
                color:Color(0xFFd60000) ,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),)
          ],
        ),
      ],
    );
  }
}
