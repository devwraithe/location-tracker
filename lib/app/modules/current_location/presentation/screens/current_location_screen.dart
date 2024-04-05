import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/cubit.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/state.dart';
import 'package:location_tracker/app/modules/current_location/presentation/widgets/map_loader.dart';

import '../../../../shared/utilities/constants.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({
    super.key,
  });

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  GoogleMapController? _mapController;
  LatLng _location = const LatLng(
    Constants.initLat,
    Constants.initLon,
  );

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() {
    BlocProvider.of<LocationCubit>(context).getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationLoaded) {
              final result = state.result;
              _location = LatLng(
                result.latitude,
                result.longitude,
              );
              _updateCameraPosition();
            }
          },
          builder: (context, state) {
            if (state is LocationLoading) {
              return const MapLoader();
            } else if (state is LocationError) {
              return Text(state.message);
            } else if (state is LocationLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      onMapCreated: (controller) async {
                        setState(() => _mapController = controller);
                      },
                      initialCameraPosition: CameraPosition(
                        target: _location,
                        zoom: Constants.zoom,
                      ),
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      markers: _createMarkers(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(state.result.toString()),
                  FilledButton(
                    onPressed: () => getLocation(),
                    child: const Text("Refresh"),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  // Method to update the camera position based on the current location
  void _updateCameraPosition() {
    if (_mapController != null) {
      setState(() {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _location,
              zoom: Constants.zoom,
            ),
          ),
        );
      });
    }
  }

  // Method to create markers
  Set<Marker> _createMarkers() {
    final markerId = "${_location.latitude}${_location.longitude}";
    return {
      Marker(
        markerId: MarkerId(markerId),
        position: _location,
        icon: BitmapDescriptor.defaultMarker,
      ),
    };
  }
}
