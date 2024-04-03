import 'package:equatable/equatable.dart';

import '../../domain/location_entity.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LocationEntity result;
  const LocationLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class LocationError extends LocationState {
  final String message;
  const LocationError(this.message);

  @override
  List<Object> get props => [message];
}
