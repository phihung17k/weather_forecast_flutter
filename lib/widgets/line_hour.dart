import 'package:flutter/material.dart';
import 'package:weather_forecast/config/weather_condition.dart';
import 'package:weather_forecast/config/weather_icon.dart';
import 'package:weather_forecast/model/forecast/hour_forecast_model.dart';

import 'hour.dart';

class LineHour extends StatelessWidget {
  final List<HourForecastModel> hourForecastList;

  LineHour({this.hourForecastList});

  @override
  Widget build(BuildContext context) {
    WeatherCondition weatherCondition = WeatherCondition();
    Map<int, WeatherIcon> _weatherIconMap = weatherCondition.weatherIconMap;
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourForecastList.length,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          HourForecastModel _hourForecastModel = hourForecastList[index];
          String time = _hourForecastModel.time?.split(" ")[1] ?? "";
          String iconFolder = _hourForecastModel.isDay ? "day" : "night";
          String iconName = _weatherIconMap[_hourForecastModel.iconCode].iconName;
          String iconPath = "assets/images/$iconFolder/$iconName.png";
          return Hour(
            tempC: _hourForecastModel.tempC,
            iconPath: iconPath,
            hour: time,
          );
        },
      ),
    );
  }

}
