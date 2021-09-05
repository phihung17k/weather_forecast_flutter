
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_forecast/bloc/weather_event.dart';
import 'package:weather_forecast/page/weather_page.dart';

import '../bloc/map/map_bloc.dart';
import '../bloc/map/map_event.dart';

class MapPage extends StatefulWidget {
  final MapBloc bloc = MapBloc();
  final String location;

  MapPage({this.location});

  @override
  _MapPageState createState() {
    print("mappage $location");
    return _MapPageState();
  }
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _controller;

  MapBloc get _bloc => widget.bloc;

  LatLng getDefaultLatLng(){
    print("argument location ${widget.location}");
    String tempLocation = widget.location.replaceAll(" ", "");
    List<String> latLong = tempLocation.split(",");
    double latitude = double.parse(latLong[0]);
    double longitude = double.parse(latLong[1]);
    return LatLng(latitude, longitude);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.addMarker(getDefaultLatLng());
    _bloc.listenerStream.listen((event) {
      if(event is ReturningPositionEvent){
        print("event ${event.marker.markerId}");
        WeatherPage.eventBus.fire(GettingReturnedDataEvent(marker: event.marker));
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: "Search Location",
            suffixIcon: Icon(Icons.search),
          ),
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Stack(
        children: [
          StreamBuilder<Marker>(
              stream: _bloc.streamMarker,
              builder: (context, snapshot) {
                Marker marker = _bloc.state.marker;
                if (snapshot.hasData && snapshot.data != null) {
                  // print("==");
                  marker = snapshot.data;
                }
                // markers.forEach((element) {
                //   print("marker ${element.markerId}");
                // });
                return marker == null ? Center(
                  child: CircularProgressIndicator(),
                ) : GoogleMap(
                  markers: {
                    marker,
                  },
                  onMapCreated: (controller) {
                    _controller = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: marker.position, //get default
                    zoom: 15.0,
                  ),
                  onTap: (LatLng position) {
                    _bloc.addMarker(position);
                  },
                );
              }),
          Positioned(
            bottom: 10.0,
            left: 60.0,
            right: 60.0,
            child: ElevatedButton(
              onPressed: () => _bloc.returnPosition(),
              child: Text("Select here"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }
}
