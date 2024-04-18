import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/shared/utilities/constants.dart';

void main() {
  test(
    'All string constants are defined correctly',
    () {
      expect(
        Constants.fontFamily,
        equals('Manrope'),
      );
      expect(
        Constants.serverError,
        equals('Error fetching location info'),
      );
      expect(
        Constants.noConnection,
        equals('No internet connection'),
      );
      expect(
        Constants.connectionTimeout,
        equals('Connection timeout'),
      );
      expect(
        Constants.permissionsDenied,
        equals('Location permissions are denied'),
      );
      expect(
        Constants.permissionsDeniedPermanently,
        equals('Location permissions are permanently denied'),
      );
    },
  );

  test(
    'All double constants are defined correctly',
    () {
      expect(
        Constants.initLat,
        equals(43.6532),
      );
      expect(
        Constants.initLon,
        equals(-79.3832),
      );
      expect(
        Constants.buttonRadius,
        equals(10.0),
      );
      expect(
        Constants.mapRadius,
        equals(12.0),
      );
    },
  );
}
