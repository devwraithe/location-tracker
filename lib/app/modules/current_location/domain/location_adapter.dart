import 'package:hive/hive.dart';

import 'location_entity.dart';

class LocationAdapter extends TypeAdapter<LocationEntity> {
  @override
  final int typeId = 0; // Unique identifier for the adapter

  @override
  LocationEntity read(BinaryReader reader) {
    final latitude = reader.readDouble();
    final longitude = reader.readDouble();

    return LocationEntity(
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  void write(BinaryWriter writer, LocationEntity obj) {
    writer.writeDouble(obj.latitude);
    writer.writeDouble(obj.longitude);
  }
}
