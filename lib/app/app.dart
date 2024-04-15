import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/cubit.dart';
import 'package:location_tracker/app/modules/current_location/presentation/screens/current_location_screen.dart';
import 'package:location_tracker/app/shared/services/di_service.dart';
import 'package:location_tracker/app/shared/utilities/constants.dart';

class LocationTracker extends StatelessWidget {
  const LocationTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LocationCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          ScreenUtil.init(context);
          return MaterialApp(
            title: 'Location Tracker',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: Constants.fontFamily,
            ),
            home: const CurrentLocationScreen(),
          );
        },
        child: const CurrentLocationScreen(),
      ),
    );
  }
}
