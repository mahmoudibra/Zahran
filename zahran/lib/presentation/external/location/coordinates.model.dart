import 'package:geolocator/geolocator.dart';

class GeoPoint {
  double lat;
  double long;

  GeoPoint(this.lat, this.long);

  factory GeoPoint.empty() {
    return GeoPoint(0.0, 0.0);
  }
  factory GeoPoint.fromGeoLineResponse(List<double> response) {
    if (response.length != 0) {
      return GeoPoint(response[1], response[0]);
    } else {
      return GeoPoint.empty();
    }
  }

  factory GeoPoint.fromPosition(Position position) {
    return GeoPoint(position.latitude, position.longitude);
  }

  bool isEmpty() {
    return lat == 0.0 && long == 0.0;
  }

  @override
  String toString() {
    return 'GeoPoint(lat: $lat, long: $long, type: Point)';
  }

  @override
  bool operator ==(Object other) => other is GeoPoint && lat == other.lat && long == other.long;

  @override
  int get hashCode => lat.hashCode + long.hashCode;

  Map<String, dynamic> toGeoPointJson() => {
        'type': 'Point',
        'coordinates': [long, lat],
      };

  Map<String, dynamic> toGeoLocationsJson() => {'latitude': lat, 'longitude': long};

  List<double> toList() {
    return [long, lat];
  }
}

class GeoBound {
  GeoPoint southwest;
  GeoPoint northeast;

  GeoBound({required this.southwest, required this.northeast});

  bool isEmpty() {
    return southwest.isEmpty() && northeast.isEmpty();
  }

  @override
  String toString() {
    return 'GeoBound(southwest: ${southwest.toString()}, northeast: ${northeast.toString()})';
  }

  factory GeoBound.empty() {
    return GeoBound(southwest: GeoPoint.empty(), northeast: GeoPoint.empty());
  }

  @override
  bool operator ==(Object other) => other is GeoBound && southwest == other.southwest && northeast == other.northeast;

  @override
  int get hashCode => southwest.hashCode + northeast.hashCode;
}

class Route {
  GeoPoint start;
  GeoPoint end;

  double distance;
  double duration;

  List<GeoPoint> polylines;
  GeoBound bound;

  Route({
    required this.start,
    required this.end,
    required this.distance,
    required this.duration,
    required this.polylines,
    required this.bound,
  });
}
