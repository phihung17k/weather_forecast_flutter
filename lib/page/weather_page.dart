import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_forecast/bloc/weather_bloc.dart';
import 'package:weather_forecast/bloc/weather_event.dart';
import 'package:weather_forecast/config/weather_condition.dart';
import 'package:weather_forecast/config/weather_icon.dart';
import 'package:weather_forecast/model/current_model.dart';
import 'package:weather_forecast/model/forecast/forecast_day_model.dart';
import 'package:weather_forecast/model/forecast/hour_forecast_model.dart';
import 'package:weather_forecast/model/location_model.dart';
import 'package:weather_forecast/widgets/line_hour.dart';

import '../route.dart';
import 'map_page.dart';

class WeatherPage extends StatefulWidget {
  static final EventBus eventBus = EventBus();
  final WeatherBloc bloc = WeatherBloc();

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherBloc get bloc => super.widget.bloc;

  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    bloc.getData(isFirst: true);

    bloc.listenerStream.listen((event) {
      print("event $event");
      if (event is NavigatorToMapPageEvent) {
        print("event.loca ${event.location}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MapPage(
                      location: event.location,
                    )));
      }
    });

    subscription = WeatherPage.eventBus.on().listen((event) {
      if (event is GettingReturnedDataEvent) {
        print("event.marker.markerId.value ${event.marker.markerId.value}");
        if (event.marker != null && event.marker.markerId.value != "default") {
          bloc.getData(location: event.marker.markerId.value);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<LocationModel>(
            stream: bloc.streamLocation,
            builder: (context, location) {
              LocationModel locationModel = bloc.state.locationModel;
              if (location.hasData && location.data != null) {
                locationModel = location.data;
              }
              return locationModel != null
                  ? RichText(
                      text: TextSpan(
                          text:
                              "${location.data.name}, ${location.data.country}",
                          style: TextStyle(fontSize: 23),
                          children: <TextSpan>[
                            TextSpan(
                                text: "\n${location.data.localTime}",
                                style: TextStyle(fontSize: 16)),
                          ]),
                      textAlign: TextAlign.center,
                    )
                  : SizedBox();
            }),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => bloc.forwardToNextPage(),
              icon: Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<StreamData>(
                stream:
                    Rx.combineLatest2(bloc.streamCurrentTime, bloc.streamTemper,
                        (CurrentModel currentModel, bool isCelsius) {
                  return StreamData(currentModel, isCelsius);
                }),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data.currentModel != null) {
                    CurrentModel currentModel = snapshot.data.currentModel;
                    WeatherCondition weatherCondition = WeatherCondition();
                    Map<int, WeatherIcon> _weatherIconMap =
                        weatherCondition.weatherIconMap;
                    // _weatherIconMap.forEach((key, value) {
                    //   print("key $key, value ${value.code}, ${value.day}, ${value.night}, ${value.iconName}");
                    // });
                    WeatherIcon _weatherIcon =
                        _weatherIconMap[currentModel.iconCode];
                    String iconFolder = "day";
                    String condition = _weatherIcon.day;
                    if (!currentModel.isDay) {
                      iconFolder = "night";
                      condition = _weatherIcon.night;
                    }
                    String iconName = _weatherIcon.iconName;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                  "assets/images/$iconFolder/$iconName.png"),
                            ),
                            InkWell(
                              onTap: () => bloc.switchCelsiusToFahrenheit(),
                              child: RichText(
                                text: TextSpan(
                                    text: formatTemperature(
                                        snapshot.data.isCelsius
                                            ? currentModel.tempC
                                            : currentModel.tempF),
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 50,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: snapshot.data.isCelsius
                                            ? "ºC"
                                            : "ºF",
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        Text("$condition"),
                        ExpansionTile(
                          title: Text("Gió"),
                          leading: Text("icon"),
                          trailing: Text("${currentModel.windSpeed} km/h"),
                        ),
                        ExpansionTile(
                          title: Text("Lượng mưa"),
                          leading: Text("icon"),
                          trailing: Text("${currentModel.precipAmount} mm"),
                        ),
                        ExpansionTile(
                          title: Text("Tầm nhìn xa"),
                          leading: Text("icon"),
                          trailing: Text("${currentModel.visibility} km"),
                        ),
                        ExpansionTile(
                          title: Text("Chỉ số UV"),
                          leading: Text("icon"),
                          trailing: Text("${currentModel.uvIndex}"),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            SizedBox(
              height: 30,
            ),
            Text("Hàng giờ"),
            SizedBox(
              height: 30,
            ),
            StreamBuilder<List<HourForecastModel>>(
                stream: bloc.streamHourList,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return LineHour(hourForecastList: snapshot.data);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            SizedBox(
              height: 30,
            ),
            Text("Hàng ngày"),
            StreamBuilder<List<ForecastDayModel>>(
                stream: bloc.streamDayList,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ForecastDayModel _forecastDay = snapshot.data[index];
                        WeatherCondition weatherCondition = WeatherCondition();
                        String iconName = weatherCondition
                            .weatherIconMap[_forecastDay.iconCode].iconName;
                        String conditionText = weatherCondition
                            .weatherIconMap[_forecastDay.iconCode].day;
                        return Card(
                          color: Colors.white,
                          elevation: 3,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: "${getWeekday(_forecastDay.date)}",
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "\n${_forecastDay.date}"),
                                      ]),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Image(
                                        image: AssetImage(
                                            "assets/images/day/$iconName.png"))),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, top: 5, right: 5),
                                    child: Text("$conditionText"),
                                  ),
                                ),
                                Text(
                                    "${_forecastDay.minTempC}℃ ⁓ ${_forecastDay.maxTempC}℃"),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }

  String formatTemperature(double temper) {
    if (temper.toInt() == temper) {
      // 32 == 32.0
      return "${temper.toInt()}";
    }
    return "$temper"; // 32 != 32.1
  }

  String getWeekday(String date) {
    DateTime time = DateTime.parse(date);
    return DateFormat('EEEE').format(time);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }
}

class StreamData {
  CurrentModel currentModel;
  bool isCelsius;

  StreamData(this.currentModel, this.isCelsius);
}
