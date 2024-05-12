import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:location_tracker/app/shared/errors/exceptions.dart';
import 'package:location_tracker/app/shared/errors/failure.dart';
import 'package:location_tracker/app/shared/services/cache_service.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late CacheService localStorageService;
  late MockHiveService mockHiveService;
  late MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    mockHiveService = MockHiveService();
    localStorageService = CacheServiceImpl(mockHiveService);
  });

  const boxName = 'testBox';
  final location = MockLocationEntity();

  test("Should cache to offline storage successfully", () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);

    // Act
    await localStorageService.cacheRequest(boxName, location);

    // Assert
    verify(mockHiveService.openBox(boxName)).called(1);
    verify(mockBox.put('location', location)).called(1);
    verify(mockBox.close()).called(1);
  });

  test('should throw CacheException when HiveError occurs', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.put(any, any)).thenThrow(HiveError('Hive error'));

    // Act
    final result = localStorageService.cacheRequest(boxName, location);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should rethrow CacheException', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.put(any, any)).thenThrow(
      const CacheException(Failure("Error")),
    );

    // Act
    final result = localStorageService.cacheRequest(boxName, location);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should throw CacheException when Exception occurs', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.put(any, any)).thenThrow(Exception('Exception error'));

    // Act
    final result = localStorageService.cacheRequest(boxName, location);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should return cached data when available', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.get(any)).thenReturn(location);

    // Act
    final result = await localStorageService.getRequest(boxName);

    // Assert
    expect(result, equals(location));
  });

  test('should throw CacheException when data is not available', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.get('location')).thenThrow(
      const CacheException(Failure("Error")),
    );

    // Act
    final result = localStorageService.getRequest(boxName);

    // Act & Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should throw CacheException when HiveError occurs', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.get(any)).thenThrow(HiveError('Hive error'));

    // Act
    final result = localStorageService.getRequest(boxName);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should rethrow CacheException', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.get(any)).thenThrow(const CacheException(Failure("Error")));

    // Act
    final result = localStorageService.getRequest(boxName);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should throw CacheException when Exception occurs', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.get(any)).thenThrow(Exception("Exception Error"));

    // Act
    final result = localStorageService.getRequest(boxName);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });
}
