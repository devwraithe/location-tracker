import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/shared/errors/failure.dart';

void main() {
  group('Failure', () {
    test('props should contain the message', () {
      // Arrange
      const failure = Failure('Test message');

      // Act
      final props = failure.props;

      // Assert
      expect(props, contains('Test message'));
    });

    test('props should not contain other messages', () {
      // Arrange
      const failure = Failure('Test message');

      // Act
      final props = failure.props;

      // Assert
      expect(props, isNot(contains('Other message')));
    });
  });
}
