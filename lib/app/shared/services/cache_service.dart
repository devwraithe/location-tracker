import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:location_tracker/app/modules/current_location/domain/location_entity.dart';

import '../errors/exceptions.dart';
import '../errors/failure.dart';
import 'hive_service.dart';

abstract class CacheService {
  Future<void> cacheRequest(String boxName, LocationEntity location);
  Future<dynamic> getRequest(String boxName);
}

class CacheServiceImpl implements CacheService {
  final HiveService hiveService;
  const CacheServiceImpl(this.hiveService);

  @override
  Future<void> cacheRequest(
    String boxName,
    dynamic data,
  ) async {
    final storage = await hiveService.openBox(boxName);

    try {
      await storage.put("location", data);
      debugPrint("Location information cached!");
    } on HiveError catch (e) {
      debugPrint("Hive error occurred: $e");
      throw CacheException(Failure(e.toString()));
    } on CacheException catch (e) {
      debugPrint("Cache error occurred: $e");
      rethrow;
    } on Exception catch (e) {
      debugPrint("Unexpected error occurred: $e");
      throw CacheException(Failure(e.toString()));
    } finally {
      try {
        storage.close();
      } catch (e) {
        debugPrint("Error closing $boxName box: $e");
      }
    }
  }

  @override
  Future<dynamic> getRequest(String boxName) async {
    final storage = await hiveService.openBox(boxName);

    try {
      final response = await storage.get("location");
      return response;
    } on HiveError catch (e) {
      debugPrint("Hive error occurred: $e");
      throw CacheException(Failure(e.toString()));
    } on CacheException catch (e) {
      debugPrint("Cache error occurred: $e");
      rethrow;
    } on Exception catch (e) {
      debugPrint("Unexpected error occurred: $e");
      throw CacheException(Failure(e.toString()));
    } finally {
      try {
        storage.close();
      } catch (e) {
        debugPrint("Error closing $boxName box: $e");
      }
    }
  }
}
