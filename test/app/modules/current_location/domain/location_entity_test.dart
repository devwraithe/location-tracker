import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_entity.dart';
import 'package:location_tracker/app/shared/utilities/constants.dart';

void main() {
  test('Should initialize with the correct values', () {
    const latitude = 43.6532;
    const longitude = -79.3832;

    const location = LocationEntity(
      latitude: Constants.initLat,
      longitude: Constants.initLon,
    );

    expect(location.latitude, latitude);
    expect(location.longitude, longitude);
  });

  test('should not be equal if their properties do not match', () {
    const latitude1 = 42.6532;
    const longitude1 = -78.3832;

    const latitude2 = 43.6532;
    const longitude2 = -79.3832;

    const location1 = LocationEntity(
      latitude: latitude1,
      longitude: longitude1,
    );
    const location2 = LocationEntity(
      latitude: latitude2,
      longitude: longitude2,
    );

    expect(location1, isNot(equals(location2)));
  });
}
