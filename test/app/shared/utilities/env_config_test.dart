import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/shared/utilities/env_config.dart';

void main() {
  test('Initialize sets baseUrl and appId', () {
    // Arrange
    const baseUrl = 'mockBaseUrl';

    // Act
    EnvConfig.initialize(baseUrl: baseUrl);

    // Assert
    expect(EnvConfig.baseUrl, baseUrl);
  });
}
