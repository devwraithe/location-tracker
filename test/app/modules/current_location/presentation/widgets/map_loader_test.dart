import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/modules/current_location/presentation/widgets/map_loader.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  group(
    'Should run tests for MapLoader',
    () {
      testWidgets(
        'Should show the MapLoader widget',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            ScreenUtilInit(builder: (context, child) {
              return const MaterialApp(
                home: MapLoader(),
              );
            }),
          );

          await tester.pump();

          expect(find.byType(Shimmer), findsOneWidget);
        },
      );
    },
  );
}
