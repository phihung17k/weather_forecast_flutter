class LocationModel {
  final String name;
  final String country;
  final String localTime;

  LocationModel({this.name, this.country,this.localTime});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json location model cannot null");
    return LocationModel(
        name: json['name'],
        country: json['country'],
        localTime: json['localtime']);
  }
}
