import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/app/shared/utilities/constants.dart';

abstract class LocationService {
  Future<LocationPermission> locationPermissions();
  Future<Position> getCurrentLocation();
}

class LocationServiceImpl implements LocationService {
  @override
  Future<LocationPermission> locationPermissions() async {
    bool locationServiceEnabled;
    LocationPermission permission;

    try {
      locationServiceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!locationServiceEnabled) {
        throw Exception("Location services are not enabled");
      } else {
        permission = await Geolocator.checkPermission();
        return permission;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Position> getCurrentLocation() async {
    bool locationServiceEnabled;
    LocationPermission permission;

    try {
      locationServiceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!locationServiceEnabled) {
        return Future.error(Constants.permissionsDisabled);
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          return Future.error(Constants.permissionsDenied);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(Constants.permissionsDeniedPermanently);
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
