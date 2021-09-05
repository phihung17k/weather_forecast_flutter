
import 'hour_forecast_model.dart';

class ForecastDayModel{
  // final DayForecastModel dayForecast;
  final String date;
  final double maxTempC;
  final double maxTempF;
  final double minTempC;
  final double minTempF;
  final double maxWind; //km per hour
  final double totalPrecipitation; //mm
  final double avgVisibility; //Average visibility in kilometer
  final double avgHumidity; //percentage
  final int chanceOfRain; //percentage
  final int chanceOfSnow; //percentage
  final int iconCode;
  final double uvIndex;
  final List<HourForecastModel> hourForecastList;

  ForecastDayModel({this.date,
    this.maxTempC,
    this.maxTempF,
    this.minTempC,
    this.minTempF,
    this.maxWind,
    this.totalPrecipitation,
    this.avgVisibility,
    this.avgHumidity,
    this.chanceOfRain,
    this.chanceOfSnow,
    this.iconCode,
    this.uvIndex, this.hourForecastList});

  factory ForecastDayModel.fromJson(Map<String, dynamic> json){
    if(json == null) throw Exception("Json of forecast day model cannot null");
    List list = json['hour'];
    List<HourForecastModel> _hourForecastList = [];
    if (list != null && list.isNotEmpty) {
      list.forEach((element) {
        _hourForecastList
            .add(HourForecastModel.fromJson(element as Map<String, dynamic>));
      });
    }
    Map<String, dynamic> dayJson = json['day'];
    return ForecastDayModel(
      date: json['date'],
      maxTempC: dayJson['maxtemp_c'],
      maxTempF: dayJson['maxtemp_f'],
      minTempC: dayJson['mintemp_c'],
      minTempF: dayJson['mintemp_f'],
      maxWind: dayJson['maxwind_kph'],
      totalPrecipitation: dayJson['totalprecip_mm'],
      avgVisibility: dayJson['avgvis_km'],
      avgHumidity: dayJson['avghumidity'],
      chanceOfRain: dayJson['daily_chance_of_rain'],
      chanceOfSnow: dayJson['daily_chance_of_snow'],
      iconCode: dayJson['condition']['code'],
      uvIndex: dayJson['uv'],
      hourForecastList: _hourForecastList,
    );
  }
}