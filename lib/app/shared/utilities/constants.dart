import 'package:location_tracker/app/shared/utilities/responsive.dart';

class Constants {
  // Strings
  static const String fontFamily = "Manrope";
  static const String serverError = "Error fetching location info";
  static const String noConnection = "No internet connection";
  static const String connectionTimeout = "Connection timeout";
  static const String permissionsDenied = "Location permissions are denied";
  static const String permissionsDeniedPermanently =
      "Location permissions are permanently denied";

  // Doubles
  static const double initLat = 43.6532;
  static const double initLon = -79.3832;
  static double zoom = Responsive.isMobile ? 6.0 : 12.0;
  static const double buttonRadius = 10.0;
  static const double mapRadius = 12.0;

  // Maps
  static final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };
}
