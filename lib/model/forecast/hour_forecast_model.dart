import 'package:weather_forecast/model/general_data_model.dart';

class HourForecastModel extends GeneralDataModel {
  final String time;
  final int cloud; //Cloud cover
  final int chanceOfRain;
  final int chanceOfSnow;

  HourForecastModel(
      {this.time,
      double tempC,
      double tempF,
      bool isDay,
      int iconCode,
      double windSpeed,
      String windDirection,
      double precipAmount,
      int humidity,
      this.cloud,
      this.chanceOfRain,
      this.chanceOfSnow,
      double visibility,
      double uvIndex})
      : super(
            tempC: tempC,
            tempF: tempF,
            isDay: isDay,
            iconCode: iconCode,
            windSpeed: windSpeed,
            windDirection: windDirection,
            precipAmount: precipAmount,
            humidity: humidity,
            visibility: visibility,
            uvIndex: uvIndex);

  factory HourForecastModel.fromJson(Map<String, dynamic> json) {
    if (json == null)
      throw Exception("Json of hour forecast model cannot null");
    return HourForecastModel(
        time: json['time'],
        tempC: json['temp_c'],
        tempF: json['temp_f'],
        isDay: json['is_day'] == 1 ? true : false,
        iconCode: json['condition']['code'],
        windSpeed: json['wind_kph'],
        windDirection: json['wind_dir'],
        precipAmount: json['precip_mm'],
        humidity: json['humidity'],
        cloud: json['cloud'],
        chanceOfRain: json['chance_of_rain'],
        chanceOfSnow: json['chance_of_snow'],
        visibility: json['vis_km'],
        uvIndex: json['uv']);
  }
}
