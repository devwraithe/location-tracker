import 'package:hive/hive.dart';

abstract class HiveService {
  Future<Box<dynamic>> openBox(String name);
  Future<void> put(String key, dynamic value);
  Future<dynamic> get(String key);
  Future<void> delete(String key);
  Future<bool> containsKey(String key);
  Future<void> close();
}

class HiveServiceImpl implements HiveService {
  @override
  Future<Box<dynamic>> openBox(String name) async {
    return await Hive.openBox(name);
  }

  @override
  Future<void> put(String key, dynamic value) async {
    final box = await openBox(key);
    await box.put(key, value);
  }

  @override
  Future<dynamic> get(String key) async {
    final box = await openBox(key);
    return await box.get(key);
  }

  @override
  Future<void> delete(String key) async {
    final box = await openBox(key);
    await box.delete(key);
  }

  @override
  Future<bool> containsKey(String key) async {
    final box = await openBox(key);
    return box.containsKey(key);
  }

  @override
  Future<void> close() async {
    await Hive.close();
  }
}
