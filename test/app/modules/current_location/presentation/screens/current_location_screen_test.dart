import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_entity.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/cubit.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/state.dart';
import 'package:location_tracker/app/modules/current_location/presentation/screens/current_location_screen.dart';
import 'package:location_tracker/app/modules/current_location/presentation/widgets/map_loader.dart';
import 'package:mockito/mockito.dart';

import '../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  const locationEntity = LocationEntity(
    longitude: 100.0,
    latitude: 50.0,
  );

  final mockLocationCubit = MockLocationCubit();

  when(mockLocationCubit.state).thenReturn(LocationLoading());

  testWidgets(
    'Should show loading UI when location is loading',
    (tester) async {
      when(mockLocationCubit.stream).thenAnswer(
        (_) => Stream<LocationState>.fromIterable(
          [LocationLoading()],
        ),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<LocationCubit>(create: (_) => mockLocationCubit),
          ],
          child: ScreenUtilInit(
            builder: (context, child) {
              return const MaterialApp(
                home: CurrentLocationScreen(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CurrentLocationScreen), findsOneWidget);
      expect(find.byType(MapLoader), findsOneWidget);
    },
  );

  testWidgets(
    'Should show error UI when location fetch fails',
    (tester) async {
      when(mockLocationCubit.stream).thenAnswer(
        (_) => Stream<LocationState>.fromIterable(
          [const LocationError("Failed to fetch current location")],
        ),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<LocationCubit>(create: (_) => mockLocationCubit),
          ],
          child: ScreenUtilInit(
            builder: (context, child) {
              return const MaterialApp(
                home: CurrentLocationScreen(),
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ScaffoldMessenger), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    },
  );

  testWidgets(
    'Should show weather overview and forecast when loaded',
    (tester) async {
      when(mockLocationCubit.stream).thenAnswer(
        (_) => Stream<LocationState>.fromIterable(
          [const LocationLoaded(locationEntity)],
        ),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<LocationCubit>(create: (_) => mockLocationCubit),
          ],
          child: ScreenUtilInit(
            builder: (context, child) {
              return const MaterialApp(
                home: CurrentLocationScreen(),
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(GoogleMap), findsOneWidget);
    },
  );
}
