import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;
import 'location.dart';
import 'dart:convert';
import 'helper.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  MainPage({this.weatherData, this.sevenWeatherData});
  final weatherData;
  final sevenWeatherData;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double latitude;
  double longitude;
  String apikey = "12a5f264ce2af19795260d35dbfbbf38";
  Helper helper = new Helper();
  int min;
  int max;
  int temperature;
  String emoji;
  String des;
  String bgImg;
  String cityName;
  var sevenIcons = new List(7);
  @override
  void initState() {
    super.initState();
    getData(widget.weatherData, widget.sevenWeatherData);
  }

  void getData(dynamic decodedData, dynamic sevenDecodedData) {
    setState(() {
      var temp = decodedData['main']['temp'];
      temperature = temp.toInt();
      var condition = decodedData['weather'][0]['id'];
      emoji = helper.getWeatherIcon(condition);
      des = helper.des(temperature);
      bgImg = helper.bgImg(condition);
      cityName = decodedData['name'];
      var temp_min = decodedData['main']['temp_min'];
      var temp_max = decodedData['main']['temp_max'];
      max = temp_max.toInt();
      min = temp_min.toInt();
      for (int j = 0; j < 7; j++) {
        var id = sevenDecodedData['daily'][j]['weather'][0]['id'];

        sevenIcons[j] = helper.getWeatherIcon(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   title: Center(
          //     child: Text('Weather app'),
          //   ),
          // ),
          body: Center(
              child: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(bgImg),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                    ),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 30.0,
                              ),
                              Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      '$cityName',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40.0),
                                    ),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      child: Text(emoji,
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50.0))),
                                  Container(
                                    child: Text(
                                      '$temperature°C',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.0),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                'Max',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 50.0),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "$max°C",
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 50.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                'Min',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 50.0),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "$min°C",
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 50.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                child: Center(
                                    child: Text(
                                  des,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 120.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              for (int i = 0; i < 7; i++)
                                sevenDayForecast(i + 1, sevenIcons[i])
                            ],
                          ),
                        ),
                      ],
                    ),
                  )))),
    );
  }
}

Widget sevenDayForecast(daysFromNow, icon) {
  var now = DateTime.now();
  var oneDayFromnow = now.add(Duration(days: daysFromNow));
  return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.transparent),
            // borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Color.fromRGBO(0, 0, 0, 0.2)
            // image: DecorationImage(
            //   image: AssetImage("images/rainy.jpg"),
            //   fit: BoxFit.cover,
            //   colorFilter: ColorFilter.mode(
            //       Colors.black.withOpacity(0.3), BlendMode.darken),
            // ),
            ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(DateFormat.E().format(oneDayFromnow),
                style: TextStyle(color: Colors.white, fontSize: 25)),
            Text(
              DateFormat.MMMd().format(oneDayFromnow),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text("$icon", style: TextStyle(color: Colors.white, fontSize: 40))
          ],
        ),
      ));
}
//12a5f264ce2af19795260d35dbfbbf38
//https://api.openweathermap.org/data/2.5/onecall?lat=13.1203178&lon=80.2331603&exclude=minutely,hourly&appid=12a5f264ce2af19795260d35dbfbbf38
