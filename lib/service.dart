import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_forecast/api.dart';
import 'package:weather_forecast/model/weather_model.dart';

/// Uri is the easiest way to use this library is via the top-level functions
///
/// http.Client() to make multiple requests to the same server
/// you can keep open a persistent connection by using a Client rather than
/// making one-off requests.

class AppService {
  //aqi: air quality
  String _combineToURL({String location}){
    return "${API.URI}${API.WEATHER_FORECAST}?key=${API.KEY}&q=$location&days=3&aqi=no&alerts=no";
  }

  Future<WeatherModel> getCurrentWeather({String location}) async {
    String url = _combineToURL(location: location ?? "Hanoi");
    final Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("AppService error: ${response.reasonPhrase}");
    }
  }


}
