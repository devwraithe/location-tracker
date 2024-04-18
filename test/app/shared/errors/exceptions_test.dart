import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/shared/errors/exceptions.dart';
import 'package:location_tracker/app/shared/errors/failure.dart';

void main() {
  test('props should contain the provided failure', () {
    // Arrange
    const failure = Failure('Test message');
    const exception = CacheException(failure);

    // Act
    final props = exception.props;

    // Assert
    expect(props, contains(failure));
  });

  test('props should contain the provided failure', () {
    // Arrange
    const failure = Failure('Test message');
    const exception = ServerException(failure);

    // Act
    final props = exception.props;

    // Assert
    expect(props, contains(failure));
  });
  test('props should contain the provided failure', () {
    // Arrange
    const failure = Failure('Test message');
    const exception = NetworkException(failure);

    // Act
    final props = exception.props;

    // Assert
    expect(props, contains(failure));
  });
}
