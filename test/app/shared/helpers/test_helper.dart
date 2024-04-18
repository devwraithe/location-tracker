import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/cubit.dart';
import 'package:location_tracker/app/shared/services/connectivity_service.dart';
import 'package:location_tracker/app/shared/services/http_service.dart';
import 'package:location_tracker/app/shared/services/location_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // Cubits
  LocationCubit,

  // Services
  ConnectivityService,
  HttpService,
  LocationService,

  // Misc
  Client,
  Connectivity,
])
void main() {}
