import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/cubit.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/state.dart';
import 'package:location_tracker/app/shared/services/location_service.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({
    super.key,
  });

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  final LocationService locationService = LocationServiceImpl();
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationCubit>(context).getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child:
            BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state is LocationLoading) {
                  return const CircularProgressIndicator();
                } else if (state is LocationError) {
                  return Text(state.message);
                } else if (state is LocationLoaded) {
                  return Text(state.result.toString());
                } else {
                  return const SizedBox();
                }
              },
            ),),
          ],
        ),
      ),
    );
  }
}
