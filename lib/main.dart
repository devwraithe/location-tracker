import 'package:flutter/material.dart';
import 'package:location_tracker/app/app.dart';

import 'app/shared/services/di_service.dart' as di;
import 'app/shared/utilities/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load and init environment variables
  const baseUrl = String.fromEnvironment("BASE_URL");
  EnvConfig.initialize(baseUrl: baseUrl);

  // Initialize dependency injectors
  await di.init();

  runApp(const LocationTracker());
}
