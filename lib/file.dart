import 'dart:io';

import 'package:flutter/services.dart';
import 'package:weather_forecast/config/weather_condition.dart';

import 'config/weather_icon.dart';

class FileProcess {
  Future<dynamic> readFile() async {
    String dataString =
        await rootBundle.loadString("assets/weather_conditions.txt");
    List<String> list = dataString.split("\n").sublist(1).where((element) {
      return element.isNotEmpty;
    }).toList();

    Map<int, WeatherIcon> weatherIconMap = new Map();

    list.forEach((element) {
      if (element.isNotEmpty) {
        element = element.replaceAll("\"", "");
        List<String> tempList = element.split(",");
        if (tempList.isNotEmpty && tempList.length == 4) {
          int code = int.parse(tempList[0]);
          String day = tempList[1];
          String night = tempList[2];
          String iconName = tempList[3];
          weatherIconMap[code] = WeatherIcon(
              code: code, day: day, night: night, iconName: iconName);
        }
      }
    });

    return weatherIconMap;
    // weatherIconMap.forEach((key, value) {
    //   print("key: $key, value ${value.code}, ${value.day}, ${value.night}, ${value.iconName}");
    // });
  }
}
