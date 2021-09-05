import 'package:weather_forecast/model/forecast/forecast_day_model.dart';

class ForecastModel {
  final List<ForecastDayModel> forecastDayList;

  ForecastModel({this.forecastDayList});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json of forecast day model cannot null");
    List list = json['forecastday'];
    List<ForecastDayModel> _forecastDayList = [];
    if (list != null && list.isNotEmpty) {
      list.forEach((element) {
        _forecastDayList
            .add(ForecastDayModel.fromJson(element as Map<String, dynamic>));
      });
    }
    return ForecastModel(forecastDayList: _forecastDayList);
  }
}
