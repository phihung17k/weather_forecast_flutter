
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/file.dart';

import 'config/weather_condition.dart';
import 'page/map_page.dart';
import 'page/weather_page.dart';
import 'route.dart';

void getWeatherCondition() async {
  WeatherCondition().weatherIconMap = await FileProcess().readFile();
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getWeatherCondition();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather Forecast",
      home: WeatherPage(),
      theme: ThemeData(buttonColor: Colors.white),
      routes: {
        Routes.weatherPage: (_) => WeatherPage(),
        Routes.mapPage: (_) => MapPage(),
      },
    );
  }
}
