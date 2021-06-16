import 'package:flutter/material.dart';
import 'package:getmyweatherapp/main_screen.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;
import 'location.dart';
import 'dart:convert';
import 'main_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  // const Splash({ Key? key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double latitude;
  double longitude;
  String apikey = "12a5f264ce2af19795260d35dbfbbf38";
  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  void getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    var sevenDecodedData;
    var decodedData;
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric'));
    http.Response res = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely,hourly,current,alerts&appid=$apikey&units=metric'));
    if (response.statusCode == 200) {
      String data = response.body;
      decodedData = jsonDecode(data);
    } else {}
    if (res.statusCode == 200) {
      String sevenData = res.body;
      sevenDecodedData = jsonDecode(sevenData);
    } else {}
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) {
        return MainPage(
            weatherData: decodedData, sevenWeatherData: sevenDecodedData);
      }),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.black,
          size: 100.0,
        ),
      ),
    );
  }
}
