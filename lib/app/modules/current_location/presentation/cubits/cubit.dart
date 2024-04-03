import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/app/modules/current_location/presentation/cubits/state.dart';

import '../../../../shared/errors/failure.dart';
import '../../domain/location_entity.dart';
import '../../domain/location_usecase.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationUsecase _usecase;

  LocationCubit(this._usecase) : super(LocationInitial());

  Future<void> getLocation() async {
    emit(LocationLoading());

    try {
      final result = await _usecase.execute();
      _emitLocationState(result);
    } catch (error) {
      emit(LocationError(error.toString()));
    }
  }

  void _emitLocationState(Either<Failure, LocationEntity> result) {
    emit(
      result.fold(
        (failure) => LocationError(failure.message),
        (response) => LocationLoaded(response),
      ),
    );
  }
}
