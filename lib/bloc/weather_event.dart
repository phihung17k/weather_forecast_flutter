
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class WeatherEvent{}

class NavigatorToMapPageEvent extends WeatherEvent{
  final String location;

  NavigatorToMapPageEvent({this.location});
}

class GettingReturnedDataEvent extends WeatherEvent{
  final Marker marker;

  GettingReturnedDataEvent({this.marker});
}