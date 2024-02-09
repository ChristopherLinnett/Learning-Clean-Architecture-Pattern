// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:starting_project/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;
  const Failure({required this.message, required this.statusCode});

  String get errorMessage => '$statusCode ' 'Error: $message';
  
  @override
  List<Object?> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  ApiFailure.fromException(APIException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
