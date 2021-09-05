import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/bloc.dart';
import 'package:weather_forecast/bloc/weather_event.dart';
import 'package:weather_forecast/bloc/weather_state.dart';
import 'package:weather_forecast/model/current_model.dart';
import 'package:weather_forecast/model/forecast/forecast_day_model.dart';
import 'package:weather_forecast/model/forecast/hour_forecast_model.dart';
import 'package:weather_forecast/model/location_model.dart';
import 'package:weather_forecast/model/weather_model.dart';
import 'package:weather_forecast/service.dart';

class WeatherBloc extends MainBloc<WeatherState> {
  final AppService _service = AppService();

  WeatherBloc() : super(state: WeatherState());

  Stream<LocationModel> get streamLocation =>
      stateStream.map((state) => state.locationModel);

  Stream<CurrentModel> get streamCurrentTime =>
      stateStream.map((state) => state.currentModel).distinct();

  Stream<bool> get streamTemper =>
      stateStream.map((state) => state.isCelsius).distinct();

  Stream<List<HourForecastModel>> get streamHourList =>
      stateStream.map((state) => state.hourForecastList).distinct();

  Stream<List<ForecastDayModel>> get streamDayList =>
      stateStream.map((state) => state.forecastDayList).distinct();

  Future<Position> getCurrentLocation() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (error) {
      if (error is PermissionDeniedException) {
        print("Location error: PermissionDeniedException");
      } else if (error is LocationServiceDisabledException) {
        print("Location error: LocationServiceDisabledException");
      } else {
        print("Location error: TimeoutException");
      }
    }
    return position;
  }

  void getData({String location, bool isFirst}) async {
    String _location = "21.0227387, 105.8194541"; //Hanoi
    if (isFirst != null && isFirst) {
      Position position = await getCurrentLocation();
      if (position != null) {
        _location = "${position.latitude}, ${position.longitude}";
        print("_location $_location");
      }
    }
    if (location != null && location.isNotEmpty) {
      _location = location;
    }
    print("loooo $_location");
    WeatherModel weather =
        await _service.getCurrentWeather(location: _location);
    //get 24h in the first day
    List<HourForecastModel> _hourForecastList =
        weather.forecastModel.forecastDayList[0].hourForecastList;
    List<ForecastDayModel> _forecastDayList =
        weather.forecastModel.forecastDayList.sublist(1);
    emit(state.copyWith(
      location: _location,
      locationModel: weather.locationModel,
      currentModel: weather.currentModel,
      hourForecastList: _hourForecastList,
      forecastDayList: _forecastDayList,
    ));
  }

  void switchCelsiusToFahrenheit() {
    emit(state.copyWith(
      isCelsius: !state.isCelsius,
    ));
  }

  void forwardToNextPage() {
    listener.add(NavigatorToMapPageEvent(
        location: state.location));
  }
}
