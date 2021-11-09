import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({@required this.message});

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure({@required message}) : super(message: message);
}

class NetworkFailure extends Failure {
  NetworkFailure({message = "Check internet connection"})
      : super(message: message);
}

class StorageFailure extends Failure {
  final message;
  StorageFailure({this.message}) : super(message: null);
}

class ConnectionFailure extends Failure {
  ConnectionFailure() : super(message: 'no_connection');
}

abstract class FailureMessages {
  static String get noConnection => "no_connection";
  static String get invalidPhone => "invalidPhone";
  static String get invalidCode => "invalidCode";
}
