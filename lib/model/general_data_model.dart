class GeneralDataModel {
  final double tempC; //celsius
  final double tempF; //fahrenheit
  final bool isDay; //day or night, use for icon
  final int iconCode;
  final double windSpeed; //km per hour
  final String windDirection;
  final double precipAmount; // Precipitation amount (lượng mưa) in millimeters
  final int humidity; // Humidity (độ ẩm) as percentage
  final double visibility; //km
  final double uvIndex;

  GeneralDataModel(
      {this.tempC,
      this.tempF,
      this.isDay,
      this.iconCode,
      this.windSpeed,
      this.windDirection,
      this.precipAmount,
      this.humidity,
      this.visibility,
      this.uvIndex});
}
