import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/modules/current_location/data/location_model.dart';
import 'package:location_tracker/app/modules/current_location/data/location_repository_impl.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_repository.dart';
import 'package:location_tracker/app/shared/errors/exceptions.dart';
import 'package:location_tracker/app/shared/errors/failure.dart';
import 'package:location_tracker/app/shared/utilities/constants.dart';
import 'package:mockito/mockito.dart';

import '../../../shared/helpers/test_helper.mocks.dart';

void main() {
  late MockConnectivityService mockConnectivityService;
  late MockLocationService mockLocationService;

  late MockRemoteDatasource mockRemoteDatasource;
  late MockLocalDatasource mockLocalDatasource;

  late LocationRepository repository;

  setUp(() {
    mockConnectivityService = MockConnectivityService();
    mockLocationService = MockLocationService();

    mockRemoteDatasource = MockRemoteDatasource();
    mockLocalDatasource = MockLocalDatasource();

    repository = LocationRepositoryImpl(
      mockRemoteDatasource,
      mockLocationService,
      mockConnectivityService,
      mockLocalDatasource,
    );
  });

  const String city = 'Melbourne, Australia';

  final locationJson = json.encode({
    "latitude": Constants.initLat,
    "longitude": Constants.initLon,
  });

  final locationModel = LocationModel.fromJson(json.decode(locationJson));
  final locationEntity = locationModel.toEntity();

  test(
    'Should return location info from API when connected to the internet',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer(
        (_) async => true,
      );
      when(mockRemoteDatasource.fetchLocationInfo()).thenAnswer(
        (_) async => locationModel,
      );

      // Act
      final result = await repository.getLocation();

      // Assert
      expect(result, equals(isA<Right>()));
      verify(mockRemoteDatasource.fetchLocationInfo()).called(1);
      verify(mockLocalDatasource.cacheLocation(locationEntity)).called(1);
    },
  );

  test(
    'Should return location info when not connected to the internet and successful',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer(
        (_) async => false,
      );
      when(mockLocalDatasource.offlineLocation()).thenAnswer(
        (_) async => locationEntity,
      );

      // Act
      final result = await repository.getLocation();

      // Assert
      expect(result, equals(isA<Right>()));
      verify(mockLocalDatasource.offlineLocation()).called(1);
    },
  );

  test(
    'Should return ServerException when api error occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDatasource.fetchLocationInfo()).thenThrow(
        const ServerException(Failure(Constants.serverError)),
      );

      // Act
      final result = await repository.getLocation();

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockRemoteDatasource.fetchLocationInfo()).called(1);
    },
  );

  test(
    'Should return NetworkException when caching error occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDatasource.fetchLocationInfo()).thenThrow(
        const NetworkException(Failure(Constants.noConnection)),
      );

      // Act
      final result = await repository.getLocation();

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockRemoteDatasource.fetchLocationInfo()).called(1);
    },
  );

  test(
    'Should return CacheException when caching error occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDatasource.fetchLocationInfo()).thenThrow(
        const CacheException(Failure("Cache error")),
      );

      // Act
      final result = await repository.getLocation();

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockRemoteDatasource.fetchLocationInfo()).called(1);
    },
  );

  test(
    'Should return a default Left when an unexpected exception occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer(
        (_) async => false,
      );
      when(mockLocalDatasource.offlineLocation()).thenThrow(
        const Left(Failure("Offline error")),
      );

      // Act
      final result = await repository.getLocation();

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockLocalDatasource.offlineLocation()).called(1);
    },
  );
}
