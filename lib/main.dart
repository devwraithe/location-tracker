import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:location_tracker/app/app.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_adapter.dart';
import 'package:path_provider/path_provider.dart';

import 'app/shared/services/di_service.dart' as di;
import 'app/shared/utilities/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load and init environment variables
  const baseUrl = String.fromEnvironment("BASE_URL");
  EnvConfig.initialize(baseUrl: baseUrl);

  // Initialize dependency injectors
  await di.init();

  // Initialize hive and register adapters - for offline support
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(LocationAdapter());

  // Initialize screen utils - for responsiveness
  await ScreenUtil.ensureScreenSize();

  runApp(const LocationTracker());
}
