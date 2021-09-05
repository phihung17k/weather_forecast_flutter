import 'package:weather_forecast/model/general_data_model.dart';

class CurrentModel extends GeneralDataModel {
  final String lastUpdatedTime;

  // final double tempC; //celsius
  // final double tempF; //fahrenheit
  // final bool isDay; //day or night, use for icon
  // final int iconCode;
  // final double windSpeed; //km per hour
  // final String windDirection;
  // final double precipAmount; // Precipitation amount (lượng mưa) in millimeters
  // final int humidity; // Humidity (độ ẩm) as percentage
  // final double visibility; //km
  // final double uvIndex;

  CurrentModel(
      {this.lastUpdatedTime,
      double tempC,
      double tempF,
      bool isDay,
      int iconCode,
      double windSpeed,
      String windDirection,
      double precipAmount,
      int humidity,
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

  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json of current model cannot null");
    return CurrentModel(
        lastUpdatedTime: json['last_updated'],
        tempC: json['temp_c'],
        tempF: json['temp_f'],
        isDay: json['is_day'] == 1 ? true : false,
        iconCode: json['condition']['code'],
        windSpeed: json['wind_kph'],
        windDirection: json['wind_dir'],
        precipAmount: json['precip_mm'],
        humidity: json['humidity'],
        visibility: json['vis_km'],
        uvIndex: json['uv']);
  }
}
