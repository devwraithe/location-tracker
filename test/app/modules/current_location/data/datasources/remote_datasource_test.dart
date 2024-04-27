import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/modules/current_location/data/datasources/remote_datasource.dart';
import 'package:location_tracker/app/modules/current_location/data/location_model.dart';
import 'package:location_tracker/app/shared/utilities/constants.dart';
import 'package:location_tracker/app/shared/utilities/env_config.dart';
import 'package:mockito/mockito.dart';

import '../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Load and init environment variables
  EnvConfig.initialize(
    baseUrl: const String.fromEnvironment("BASE_URL"),
  );

  late MockHttpService mockHttpService;

  late RemoteDatasource datasource;

  setUp(() {
    mockHttpService = MockHttpService();
    datasource = RemoteDatasourceImpl(mockHttpService);
  });

  final locationJson = {
    "latitude": 7.3782,
    "longitude": 3.9062,
  };

  test(
    'Should return location info when connected to the internet and successful',
    () async {
      // Arrange

      when(mockHttpService.getRequest(
        any,
        headers: Constants.headers,
        errorMessage: Constants.serverError,
      )).thenAnswer(
        (_) async => locationJson,
      );

      // Act
      final result = await datasource.fetchLocationInfo();

      // Assert
      expect(result, equals(isA<LocationModel>()));
    },
  );
}
