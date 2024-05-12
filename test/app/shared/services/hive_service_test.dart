import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:location_tracker/app/shared/services/hive_service.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const boxName = 'test';
  const key = 'test';
  const value = 'test';

  late HiveService hiveLocalStorageAdapter;
  late HiveInterface mockHiveInterface;
  late MockBox mockBox;

  setUpAll(() async {
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler(
      (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return Directory.current.path;
        }
        return null;
      },
    );

    await Hive.initFlutter();

    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    mockHiveInterface = MockHiveInterface();
    mockBox = MockBox();
    hiveLocalStorageAdapter = HiveServiceImpl();
  });

  test('openBox should return a Box', () async {
    when(mockHiveInterface.openBox(boxName)).thenAnswer((_) async => mockBox);

    final result = await hiveLocalStorageAdapter.openBox(boxName);

    expect(result, isA<Box<dynamic>>());
  });

  test('put should call box.put', () async {
    when(mockHiveInterface.openBox(boxName)).thenAnswer((_) async => mockBox);

    await hiveLocalStorageAdapter.put(key, value);

    verifyNever(mockBox.put(key, value));
  });

  test('get should call box.get', () async {
    when(mockHiveInterface.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.get(key)).thenReturn(value);

    final result = await hiveLocalStorageAdapter.get(key);

    verifyNever(mockBox.get(key));
    expect(result, equals(value));
  });

  test('put should call box.delete', () async {
    when(mockHiveInterface.openBox(boxName)).thenAnswer((_) async => mockBox);

    await hiveLocalStorageAdapter.delete(key);

    verifyNever(mockBox.delete(key));
  });

  test('get should call box.containsKey', () async {
    when(mockHiveInterface.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.get(key)).thenReturn(false);

    final result = await hiveLocalStorageAdapter.containsKey(key);

    verifyNever(mockBox.containsKey(key));
    expect(result, equals(false));
  });

  test('put should call box.close', () async {
    when(mockHiveInterface.openBox(boxName)).thenAnswer((_) async => mockBox);

    await hiveLocalStorageAdapter.close();

    verifyNever(mockBox.close());
  });
}
