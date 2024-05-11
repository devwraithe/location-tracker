import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';
import 'package:location_tracker/app/modules/current_location/data/datasources/local_datasource.dart';
import 'package:location_tracker/app/modules/current_location/data/datasources/remote_datasource.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_entity.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_repository.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_usecase.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/cubit.dart';
import 'package:location_tracker/app/shared/services/cache_service.dart';
import 'package:location_tracker/app/shared/services/connectivity_service.dart';
import 'package:location_tracker/app/shared/services/http_service.dart';
import 'package:location_tracker/app/shared/services/location_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // Cubits
  LocationCubit,

  // Usecases
  LocationUsecase,

  // Entities
  LocationEntity,

  // Repository
  LocationRepository,

  // Datasource
  LocalDatasource,
  RemoteDatasource,

  // Services
  ConnectivityService,
  HttpService,
  LocationService,
  CacheService,

  // Misc
  Client,
  Connectivity,
])
void main() {}
