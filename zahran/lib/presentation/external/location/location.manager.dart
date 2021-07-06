import 'coordinates.model.dart';

abstract class LocationManager {
  Future<bool> checkIfLocationServiceEnabled();

  Future<GeoPoint> getCurrentLocation();
}
