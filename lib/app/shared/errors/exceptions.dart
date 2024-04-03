import 'dart:io';

import 'package:equatable/equatable.dart';

import 'failure.dart';

// Remote datasource exceptions
class ServerException extends Equatable implements Exception {
  final Failure failure;
  const ServerException(this.failure);
  @override
  List<Object?> get props => [failure];
}

class NetworkException extends Equatable implements IOException {
  final Failure failure;
  const NetworkException(this.failure);
  @override
  List<Object?> get props => [failure];
}

class HttpException extends Equatable implements Exception {
  final Failure failure;
  const HttpException(this.failure);
  @override
  List<Object?> get props => [failure];
}

class NoConnectionException extends Equatable implements Exception {
  final Failure failure;
  const NoConnectionException(this.failure);
  @override
  List<Object?> get props => [failure];
}

// Local datasource exceptions
class CacheException extends Equatable implements Exception {
  final Failure failure;
  const CacheException(this.failure);
  @override
  List<Object?> get props => [failure];
}
