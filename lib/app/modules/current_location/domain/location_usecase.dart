import 'package:dartz/dartz.dart';

import '../../../shared/errors/failure.dart';
import 'location_entity.dart';
import 'location_repository.dart';

abstract class LocationUsecase {
  Future<Either<Failure, LocationEntity>> execute();
}

class LocationUsecaseImpl implements LocationUsecase {
  final LocationRepository _repo;
  LocationUsecaseImpl(this._repo);

  @override
  Future<Either<Failure, LocationEntity>> execute() async {
    return await _repo.getLocation();
  }
}
