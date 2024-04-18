import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/app.dart';
import 'package:location_tracker/app/modules/current_location/presentation/screens/current_location_screen.dart';
import 'package:location_tracker/app/shared/services/di_service.dart' as di;

void main() {
  testWidgets(
    'Should build RockBand widget',
    (WidgetTester tester) async {
      di.init();

      // pump the widget tree
      await tester.pumpWidget(
        const LocationTracker(),
      );

      await tester.pump();

      // Verify
      expect(find.byType(MultiBlocProvider), findsOneWidget);
      expect(find.byType(ScreenUtilInit), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(CurrentLocationScreen), findsOneWidget);
    },
  );
}
