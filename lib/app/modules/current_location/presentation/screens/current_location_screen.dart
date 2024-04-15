import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/cubit.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/state.dart';
import 'package:location_tracker/app/modules/current_location/presentation/widgets/map_loader.dart';
import 'package:location_tracker/app/shared/utilities/responsive.dart';

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
    final isMobile = Responsive.isMobile;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 18 : 28),
          child: Column(
            children: [
              Text(
                "Find your location!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Responsive.headlineMedium,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: isMobile ? 24 : 32),
              Expanded(
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
                    if (state is LocationError) {
                      final snackBar = SnackBar(
                        content: Text(state.message),
                        duration: const Duration(seconds: 3),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  builder: (context, state) {
                    if (state is LocationLoading) {
                      return const MapLoader();
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Constants.mapRadius,
                              ),
                              child: GoogleMap(
                                onMapCreated: (controller) async {
                                  setState(() => _mapController = controller);
                                },
                                initialCameraPosition: CameraPosition(
                                  target: _location,
                                  zoom: Constants.zoom,
                                ),
                                zoomControlsEnabled: false,
                                myLocationEnabled: false,
                                myLocationButtonEnabled: false,
                                markers: _createMarkers(),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: isMobile ? 24 : 36),
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  return FilledButton(
                    onPressed: () {
                      if (state is! LocationLoading) {
                        getLocation();
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: state is LocationLoading
                          ? Colors.grey[400]
                          : Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Constants.buttonRadius,
                        ),
                      ),
                      minimumSize: Size(
                        double.infinity,
                        isMobile ? 52 : 72,
                      ),
                    ),
                    child: state is LocationLoading
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Refresh",
                            style: TextStyle(
                              fontSize: Responsive.bodyLarge,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
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
