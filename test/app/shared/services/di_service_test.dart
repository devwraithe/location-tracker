import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:location_tracker/app/modules/current_location/data/datasources/remote_datasource.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_repository.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_usecase.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/cubit.dart';
import 'package:location_tracker/app/shared/services/connectivity_service.dart';
import 'package:location_tracker/app/shared/services/di_service.dart';
import 'package:location_tracker/app/shared/services/http_service.dart';
import 'package:location_tracker/app/shared/services/location_service.dart';

void main() {
  setUp(() => init()); // Initialize your DI service

  tearDown(() => GetIt.I.reset()); // Reset GetIt instance after each test

  test('All dependencies are registered', () {
    // Cubits
    expect(GetIt.I<LocationCubit>(), isNotNull);

    // Usecases
    expect(GetIt.I<LocationUsecase>(), isNotNull);

    // Repositories
    expect(GetIt.I<LocationRepository>(), isNotNull);

    // Datasources
    expect(GetIt.I<RemoteDatasource>(), isNotNull);

    // Services
    expect(GetIt.I<ConnectivityService>(), isA<ConnectivityServiceImpl>());
    expect(GetIt.I<LocationService>(), isA<LocationServiceImpl>());
    expect(GetIt.I<HttpService>(), isA<HttpServiceImpl>());

    // Http client
    expect(GetIt.I<http.Client>(), isNotNull);
  });
}
