part of 'models.dart';

class LocationModel {
  final double lat;
  final double lang;

  const LocationModel({required this.lat, required this.lang});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        lat: json['lat'] as double,
        lang: json['lang'] as double,
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lang': lang,
      };
}
