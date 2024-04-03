class Constants {
  // Strings
  static const String serverError = "Error fetching location info";
  static const String noConnection = "No internet connection";
  static const String connectionTimeout = "Connection timeout";
  static const String permissionsDisabled = "Location permissions are disabled";
  static const String permissionsGranted = "Location permissions are granted";
  static const String permissionsDenied = "Location permissions are denied";
  static const String permissionsDeniedPermanently =
      "Location permissions are permanently denied";

  // Maps
  static final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };
}
