import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/app/modules/current_location/data/datasources/remote_datasource.dart';

import '../../../shared/errors/exceptions.dart';
import '../../../shared/errors/failure.dart';
import '../../../shared/services/location_service.dart';
import '../domain/location_entity.dart';
import '../domain/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final RemoteDatasource remoteDatasource;
  final LocationService locationService;

  LocationRepositoryImpl(
    this.remoteDatasource,
    this.locationService,
  );

  @override
  Future<Either<Failure, LocationEntity>> getLocation() async {
    try {
      // final permission = await locationService.locationPermissions();
      const permission = LocationPermission.deniedForever;
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        final currentLocation = await locationService.getCurrentLocation();
        final locationEntity = LocationEntity(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        );
        return Right(locationEntity);
      } else {
        final result = await remoteDatasource.fetchLocationInfo();
        final locationEntity = result.toEntity();
        return Right(locationEntity);
      }
    } on ServerException catch (e) {
      return Left(e.failure);
    } on NetworkException catch (e) {
      return Left(e.failure);
    } on CacheException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
