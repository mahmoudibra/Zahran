part of 'models.dart';

class LocationModel {
  final double lat;
  final double lang;

  const LocationModel({required this.lat, required this.lang});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        lat: double.tryParse(json['lat']?.toString() ?? "") ?? 0,
        lang:
            double.tryParse((json['lang'] ?? json['lng'])?.toString() ?? "") ??
                0,
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lang': lang,
      };
}
