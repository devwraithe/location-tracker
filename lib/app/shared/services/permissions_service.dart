import 'package:geolocator/geolocator.dart';

abstract class PermissionService {
  Future<LocationPermission> checkPermission();
  Future<LocationPermission> requestPermission();
}

class PermissionServiceImpl implements PermissionService {
  @override
  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  @override
  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }
}
