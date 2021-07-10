import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:zahran/presentation/exceptions/location_service.exception.dart';
import 'package:zahran/presentation/external/location/location.manager.dart';

import 'coordinates.model.dart';

class LocationManagerImpl implements LocationManager {
  LocationManagerImpl();

  @override
  Future<bool> checkIfLocationServiceEnabled() async {
    var locationPermission = await Geolocator.checkPermission();
    switch (locationPermission) {
      case LocationPermission.always:
        {
          return Future.value(true);
        }
      case LocationPermission.whileInUse:
        {
          return Future.value(true);
        }
      case LocationPermission.denied:
        {
          return Future.value(false);
        }
      case LocationPermission.deniedForever:
        {
          return Future.value(false);
        }
      default:
        {
          return Future.value(false);
        }
    }
  }

  @override
  Future<GeoPoint> getCurrentLocation() async {
    try {
      Position position;
      final desiredAccuracy =
          Platform.isAndroid ? LocationAccuracy.high : LocationAccuracy.medium;

      position =
          await Geolocator.getCurrentPosition(desiredAccuracy: desiredAccuracy)
              .timeout(Duration(seconds: 10), onTimeout: () {
        return Future.error(LocationServiceException());
      });
      return GeoPoint(position.latitude, position.longitude);
    } catch (exception) {
      return Future.error(LocationServiceException());
    }
  }
}
