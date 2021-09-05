import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/model/current_model.dart';
import 'package:weather_forecast/model/forecast/forecast_day_model.dart';
import 'package:weather_forecast/model/forecast/hour_forecast_model.dart';
import 'package:weather_forecast/model/location_model.dart';

class WeatherState extends Equatable {
  final String location;
  final LocationModel locationModel;
  final CurrentModel currentModel;
  final bool isCelsius;
  final List<HourForecastModel> hourForecastList;
  final List<ForecastDayModel> forecastDayList;

  WeatherState(
      {this.location,
      this.locationModel,
      this.currentModel,
      this.isCelsius = true,
      this.hourForecastList,
      this.forecastDayList});

  WeatherState copyWith(
      {String location,
      LocationModel locationModel,
      CurrentModel currentModel,
      bool isCelsius,
      List<HourForecastModel> hourForecastList,
      List<ForecastDayModel> forecastDayList}) {
    return WeatherState(
      location: location ?? this.location,
      locationModel: locationModel ?? this.locationModel,
      currentModel: currentModel ?? this.currentModel,
      isCelsius: isCelsius ?? this.isCelsius,
      hourForecastList: hourForecastList ?? this.hourForecastList,
      forecastDayList: forecastDayList ?? this.forecastDayList,
    );
  }

  @override
  List<Object> get props => [
        location,
        locationModel,
        currentModel,
        isCelsius,
        hourForecastList,
        forecastDayList
      ];
}
