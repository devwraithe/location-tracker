import 'package:flutter/material.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({
    super.key,
  });

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Location Tracker"),
      ),
    );
  }
}
