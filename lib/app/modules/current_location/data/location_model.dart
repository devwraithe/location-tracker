import 'package:equatable/equatable.dart';

import '../domain/location_entity.dart';

class LocationModel extends Equatable {
  final double latitude, longitude;

  const LocationModel({
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  LocationEntity toEntity() {
    return LocationEntity(
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  List<Object> get props => [latitude, longitude];
}
