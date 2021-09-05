import 'package:flutter/material.dart';

class Hour extends StatelessWidget {

  final double tempC;
  final String iconPath;
  final String hour;

  Hour({this.tempC, this.iconPath, this.hour});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${formatTemperature(tempC)}℃"),
        Image(
          image: AssetImage("$iconPath"),
        ),
        Text("$hour"),
      ],
    );
  }

  String formatTemperature(double temper) {
    if (temper.toInt() == temper) {
      // 32 == 32.0
      return "${temper.toInt()}";
    }
    return "$temper"; // 32 != 32.1
  }
}
