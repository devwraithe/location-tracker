import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/app/shared/helpers/snack_helper.dart';
import 'package:location_tracker/app/shared/utilities/constants.dart';

abstract class LocationService {
  Future<Position> getCurrentLocation(BuildContext context);
}

class LocationServiceImpl implements LocationService {
  @override
  Future<Position> getCurrentLocation(BuildContext context) async {
    bool locationServiceEnabled;
    LocationPermission permission;

    try {
      locationServiceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!locationServiceEnabled) {
        SnackHelper.error(context, Constants.permissionsDisabled);
        return Future.error(Constants.permissionsDisabled);
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          SnackHelper.error(context, Constants.permissionsDenied);
          return Future.error(Constants.permissionsDenied);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        SnackHelper.error(context, Constants.permissionsDeniedPermanently);
        return Future.error(Constants.permissionsDeniedPermanently);
      }

      SnackHelper.success(context, Constants.permissionsGranted);
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
