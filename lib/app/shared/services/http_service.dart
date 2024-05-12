import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:location_tracker/app/shared/errors/failure.dart';

import '../errors/exceptions.dart';
import '../utilities/constants.dart';

abstract class HttpService {
  Future<Map<String, dynamic>> getRequest(
    String url, {
    Map<String, String>? headers,
    required String errorMessage,
  });
}

class HttpServiceImpl implements HttpService {
  final Client client;

  const HttpServiceImpl(this.client);

  @override
  Future<Map<String, dynamic>> getRequest(
    String url, {
    Map<String, String>? headers,
    required String errorMessage,
  }) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ServerException(Failure(errorMessage));
      }
    } on SocketException {
      throw const NetworkException(Failure(Constants.noConnection));
    } on TimeoutException {
      throw const NetworkException(Failure(Constants.connectionTimeout));
    } on ClientException catch (e) {
      throw NetworkException(Failure(e.message));
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      throw Exception(Failure(e.toString()));
    }
  }
}
