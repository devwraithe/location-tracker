import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:location_tracker/app/shared/services/http_service.dart';
import 'package:location_tracker/app/shared/utilities/constants.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late MockClient mockClient;
  late HttpService httpService;

  setUp(() {
    mockClient = MockClient();
    httpService = HttpServiceImpl(mockClient);
  });

  const response = {'key1': "value1"};
  const url = "https://test.co/json";

  test('getRequest returns decoded response on success', () async {
    // Arrange
    when(
      mockClient.get(
        Uri.parse(url),
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => Response(
        json.encode(response),
        200,
        headers: Constants.headers,
      ),
    );

    // Act
    final result = await httpService.getRequest(
      url,
      headers: Constants.headers,
      errorMessage: 'Error',
    );

    // Assert
    expect(result, response);
  });
}
