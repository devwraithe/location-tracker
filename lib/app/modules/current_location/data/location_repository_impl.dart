import 'package:dartz/dartz.dart';
import 'package:location_tracker/app/modules/current_location/data/datasources/local_datasource.dart';
import 'package:location_tracker/app/modules/current_location/data/datasources/remote_datasource.dart';

import '../../../shared/errors/exceptions.dart';
import '../../../shared/errors/failure.dart';
import '../../../shared/services/connectivity_service.dart';
import '../../../shared/services/location_service.dart';
import '../domain/location_entity.dart';
import '../domain/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final RemoteDatasource remoteDatasource;
  final LocationService locationService;
  final ConnectivityService connectivityService;
  final LocalDatasource localDatasource;

  LocationRepositoryImpl(
    this.remoteDatasource,
    this.locationService,
    this.connectivityService,
    this.localDatasource,
  );

  Future<Either<Failure, LocationEntity>> getRemoteLocation() async {
    try {
      final response = await remoteDatasource.fetchLocationInfo();
      final locationEntity = response.toEntity();
      await localDatasource.cacheLocation(locationEntity);
      return Right(locationEntity);
    } on ServerException catch (e) {
      return Left(e.failure);
    } on NetworkException catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, LocationEntity>> getCachedLocation() async {
    try {
      final cache = await localDatasource.offlineLocation();
      final locationEntity = LocationEntity(
        latitude: cache.latitude,
        longitude: cache.longitude,
      );
      return Right(locationEntity);
    } on CacheException catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, LocationEntity>> getGpsLocation() async {
    try {
      final gps = await locationService.getCurrentLocation();
      final locationEntity = LocationEntity(
        latitude: gps.latitude,
        longitude: gps.longitude,
      );
      await localDatasource.cacheLocation(locationEntity);
      return Right(locationEntity);
    } on PermissionException catch (e) {
      return Left(e.failure);
    } on ServerException catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> getLocation() async {
    try {
      final isConnected = await connectivityService.isConnected();
      final isGpsEnabled = await locationService.isLocationEnabled();

      if (isConnected) {
        // Internet is available, use API
        return await getRemoteLocation();
      } else if (!isConnected && !isGpsEnabled) {
        // Internet and GPS is not available, use Cache
        return await getCachedLocation();
      } else {
        // Neither of the above, use GPS
        return await getGpsLocation();
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
