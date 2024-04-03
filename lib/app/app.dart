import 'package:flutter/material.dart';
import 'package:location_tracker/app/modules/current_location/presentation/screens/current_location_screen.dart';

class LocationTracker extends StatelessWidget {
  const LocationTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pinkAccent,
        ),
        useMaterial3: true,
      ),
      home: const CurrentLocationScreen(),
    );
  }
}
