import 'package:location_tracker/app/shared/utilities/env_config.dart';

import '../../../../shared/services/http_service.dart';
import '../../../../shared/utilities/constants.dart';
import '../location_model.dart';

abstract class RemoteDatasource {
  Future<LocationModel> fetchLocationInfo();
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final HttpService http;

  const RemoteDatasourceImpl(this.http);

  @override
  Future<LocationModel> fetchLocationInfo() async {
    final Map<String, dynamic> response = await http.getRequest(
      EnvConfig.baseUrl,
      headers: Constants.headers,
      errorMessage: Constants.serverError,
    );

    return LocationModel.fromJson(response);
  }
}
