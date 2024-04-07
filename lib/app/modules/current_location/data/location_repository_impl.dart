import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
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

  LocationRepositoryImpl(
    this.remoteDatasource,
    this.locationService,
    this.connectivityService,
  );

  @override
  Future<Either<Failure, LocationEntity>> getLocation() async {
    try {
      final isConnected = await connectivityService.isConnected();
      final isGpsEnabled = await Geolocator.isLocationServiceEnabled();

      if (isConnected || !isGpsEnabled) {
        // If there is internet or GPS is not enabled, use the API
        final result = await remoteDatasource.fetchLocationInfo();
        final locationEntity = result.toEntity();
        return Right(locationEntity);
      } else {
        // If there is no internet or GPS is enabled, use the GPS
        final currentLocation = await locationService.getCurrentLocation();
        final locationEntity = LocationEntity(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        );
        return Right(locationEntity);
      }
    } on PermissionException catch (e) {
      return Left(e.failure);
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
