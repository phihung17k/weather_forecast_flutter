
import 'package:weather_forecast/config/weather_icon.dart';

class WeatherCondition{
  static final WeatherCondition _instance = WeatherCondition._internal();

  factory WeatherCondition(){
    return _instance;
  }

  WeatherCondition._internal();

  Map<int, WeatherIcon> weatherIconMap;

  // Map<int, WeatherIcon> get weatherIconMap => _weatherIconMap;
  //
  // set setWeatherMap(Map<int, WeatherIcon> map) => _weatherIconMap = map;
}