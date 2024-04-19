import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:location_tracker/app/app.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_adapter.dart';
import 'package:location_tracker/app/shared/services/di_service.dart' as di;
import 'package:path_provider/path_provider.dart';

void main() {
  testWidgets('Should initialize the app', (tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    di.init();

    // Initialize hive and register adapters - for offline support
    Directory dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
    Hive.registerAdapter(LocationAdapter());

    await ScreenUtil.ensureScreenSize();

    await tester.pumpWidget(
      const LocationTracker(),
    );
  });
}
