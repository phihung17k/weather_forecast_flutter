import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_forecast/bloc.dart';
import 'package:weather_forecast/bloc/map/map_event.dart';
import 'package:weather_forecast/bloc/map/map_state.dart';

class MapBloc extends MainBloc<MapState> {
  MapBloc() : super(state: MapState());

  Stream<Marker> get streamMarker =>
      stateStream.map((state) => state.marker);

  void addMarker(LatLng position){
    // state.markers.add();
    print("position ${position.latitude}, ${position.longitude}");
    emit(state.copyWith(
      marker: Marker(
        markerId: MarkerId("${position.latitude}, ${position.longitude}"),
        position: position,
      )/*state.markers*/,
    ));
  }

  void returnPosition(){
    listener.add(ReturningPositionEvent(marker: state.marker));
  }
}
