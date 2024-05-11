import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../../shared/helpers/test_helper.mocks.dart';

void main() {
  late LocationUsecase usecase;
  late MockLocationRepository locationRepository;

  setUp(() {
    locationRepository = MockLocationRepository();
    usecase = LocationUsecaseImpl(locationRepository);
  });

  final location = MockLocationEntity();

  test('Should return the location info', () async {
    // "On the fly" implementation of the Repository using the Mockito package.
    when(locationRepository.getLocation()).thenAnswer(
      (_) async => Right(location),
    );

    // The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase.execute();

    // UseCase should simply return whatever was returned from the Repository
    expect(result, equals(Right(location)));
    // Verify that the method has been called on the Repository
    verify(locationRepository.getLocation());
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(locationRepository);
  });
}
