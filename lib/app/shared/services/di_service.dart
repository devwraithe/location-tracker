import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:location_tracker/app/shared/services/location_service.dart';
import 'package:location_tracker/app/shared/services/permissions_service.dart';

import '../../modules/current_location/data/datasources/remote_datasource.dart';
import '../../modules/current_location/data/location_repository_impl.dart';
import '../../modules/current_location/domain/location_repository.dart';
import '../../modules/current_location/domain/location_usecase.dart';
import '../../modules/current_location/presentation/cubits/cubit.dart';
import 'connectivity_service.dart';
import 'http_service.dart';

// Service locator (sl)
final sl = GetIt.instance;

void regSingleton<T extends Object>(T Function() factFunc) {
  sl.registerLazySingleton(factFunc);
}

Future<void> init() async {
  // Cubits
  regSingleton<LocationCubit>(() => LocationCubit(sl()));

  // Usecases
  regSingleton<LocationUsecase>(() => LocationUsecaseImpl(sl()));

  // Repositories
  regSingleton<LocationRepository>(
    () => LocationRepositoryImpl(sl(), sl(), sl()),
  );

  // Datasources
  regSingleton<RemoteDatasource>(() => RemoteDatasourceImpl(sl()));

  // Services
  regSingleton<HttpService>(() => HttpServiceImpl());
  regSingleton<LocationService>(() => LocationServiceImpl(sl()));
  regSingleton<PermissionService>(() => PermissionServiceImpl());
  regSingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(Connectivity()),
  );

  // Http client
  regSingleton(() => http.Client());
}
