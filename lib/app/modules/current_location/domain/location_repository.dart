import 'package:dartz/dartz.dart';

import '../../../shared/errors/failure.dart';
import 'location_entity.dart';

abstract class LocationRepository {
  Future<Either<Failure, LocationEntity>> getLocation();
}
