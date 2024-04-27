import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/modules/current_location/data/datasources/local_datasource.dart';
import 'package:mockito/mockito.dart';

import '../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  late LocalDatasource datasource;
  late MockCacheService mockCacheService;

  setUp(() {
    mockCacheService = MockCacheService();
    datasource = LocalDatasourceImpl(mockCacheService);
  });

  final mockLocation = MockLocationEntity();

  test(
    'Should cache the location when the cacheRequest method is triggered',
    () async {
      when(mockCacheService.cacheRequest(any, mockLocation)).thenAnswer(
        (_) async {},
      );

      await datasource.cacheLocation(mockLocation);

      verify(
        mockCacheService.cacheRequest(any, mockLocation),
      ).called(1);
    },
  );

  test(
    'Should fetch the weather info that is stored in offline storage',
    () async {
      when(mockCacheService.getRequest(any)).thenAnswer(
        (_) async => mockLocation,
      );

      await datasource.offlineLocation();

      verify(
        mockCacheService.getRequest(any),
      ).called(1);
    },
  );
}
