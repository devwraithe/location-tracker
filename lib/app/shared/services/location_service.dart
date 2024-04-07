import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/app/shared/errors/failure.dart';
import 'package:location_tracker/app/shared/services/permissions_service.dart';
import 'package:location_tracker/app/shared/utilities/constants.dart';

import '../errors/exceptions.dart';

abstract class LocationService {
  Future<Position> getCurrentLocation();
}

class LocationServiceImpl implements LocationService {
  final PermissionService permissionService;

  LocationServiceImpl(this.permissionService);

  @override
  Future<Position> getCurrentLocation() async {
    try {
      // Check location permission before attempting to get the current location
      LocationPermission permission = await permissionService.checkPermission();

      if (permission == LocationPermission.denied) {
        // Request permission if it's not granted
        permission = await permissionService.requestPermission();

        if (permission == LocationPermission.denied) {
          // Handle the case when permission is denied
          throw const PermissionException(
            Failure(Constants.permissionsDenied),
          );
        }
      }

      // Fetch current position after obtaining permission
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      debugPrint("Exception thrown from here");
      throw Exception(e.toString());
    }
  }
}
