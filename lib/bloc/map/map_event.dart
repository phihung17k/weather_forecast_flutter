
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent{}

class ReturningPositionEvent{
  final Marker marker;

  ReturningPositionEvent({this.marker});
}