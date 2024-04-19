import 'dart:async';

import 'package:location_tracker/app/modules/current_location/domain/location_entity.dart';
import 'package:location_tracker/app/shared/services/cache_service.dart';

import '../../../../shared/utilities/constants.dart';

abstract class LocalDatasource {
  Future<void> cacheLocation(LocationEntity location);
  Future<LocationEntity> offlineLocation();
}

class LocalDatasourceImpl implements LocalDatasource {
  final CacheService cacheService;

  const LocalDatasourceImpl(this.cacheService);

  @override
  Future<void> cacheLocation(LocationEntity location) async {
    final response = await cacheService.cacheRequest(
      Constants.boxName,
      location,
    );

    return response;
  }

  @override
  Future<LocationEntity> offlineLocation() async {
    final result = await cacheService.getRequest(Constants.boxName);

    return result;
  }
}
