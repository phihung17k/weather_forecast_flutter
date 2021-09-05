import 'package:weather_forecast/model/current_model.dart';
import 'package:weather_forecast/model/forecast/forecast_model.dart';
import 'package:weather_forecast/model/location_model.dart';

class WeatherModel {
  final LocationModel locationModel;
  final CurrentModel currentModel;
  final ForecastModel forecastModel;

  WeatherModel({this.locationModel, this.currentModel, this.forecastModel});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json weather model cannot null");
    LocationModel _locationModel =
        LocationModel.fromJson(json['location'] as Map<String, dynamic>);
    CurrentModel _currentModel =
        CurrentModel.fromJson(json['current'] as Map<String, dynamic>);
    ForecastModel _forecastModel =
        ForecastModel.fromJson(json['forecast'] as Map<String, dynamic>);
    return WeatherModel(
        locationModel: _locationModel,
        currentModel: _currentModel,
        forecastModel: _forecastModel);
  }
}
