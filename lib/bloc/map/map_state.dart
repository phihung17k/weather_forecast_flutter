
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState extends Equatable{
  final Marker marker;

  MapState({this.marker});

  MapState copyWith({Marker marker}){
    return MapState(marker: marker);
  }

  @override
  List<Object> get props => [marker];
}