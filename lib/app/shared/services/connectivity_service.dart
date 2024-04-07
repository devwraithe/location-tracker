import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityService {
  Future<bool> isConnected();
}

class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;
  ConnectivityServiceImpl(this._connectivity);

  @override
  Future<bool> isConnected() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
