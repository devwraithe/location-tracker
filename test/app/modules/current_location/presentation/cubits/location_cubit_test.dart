import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_entity.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/cubit.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/state.dart';
import 'package:location_tracker/app/shared/errors/failure.dart';
import 'package:location_tracker/app/shared/utilities/constants.dart';
import 'package:mockito/mockito.dart';

import '../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  late LocationCubit cubit;
  late MockLocationUsecase mockLocationUsecase;

  setUp(() {
    mockLocationUsecase = MockLocationUsecase();
    cubit = LocationCubit(mockLocationUsecase);
  });

  tearDown(() {
    // Close the cubit after each test
    cubit.close();
  });

  const locationEntity = LocationEntity(
    longitude: Constants.initLon,
    latitude: Constants.initLat,
  );

  // Test the initial state of the cubit
  test(
    'Initial state should be empty',
    () => expect(
      cubit.state,
      LocationInitial(),
    ),
  );

  blocTest<LocationCubit, LocationState>(
    'Should emit LocationError when an error occurs',
    setUp: () {
      when(mockLocationUsecase.execute()).thenAnswer(
        (_) async => const Left(
          Failure('Error retrieving current location'),
        ),
      );
    },
    build: () => cubit,
    act: (cubit) => cubit.getLocation(),
    expect: () => [
      LocationLoading(),
      const LocationError(
        'Error retrieving current location',
      ),
    ],
  );

  blocTest<LocationCubit, LocationState>(
    'Should emit LocationLoaded when internet is available and returns location',
    setUp: () {
      when(mockLocationUsecase.execute()).thenAnswer(
        (_) async => const Right(
          locationEntity,
        ),
      );
    },
    build: () => cubit,
    act: (cubit) => cubit.getLocation(),
    expect: () => [
      LocationLoading(),
      const LocationLoaded(
        locationEntity,
      ),
    ],
  );
}
