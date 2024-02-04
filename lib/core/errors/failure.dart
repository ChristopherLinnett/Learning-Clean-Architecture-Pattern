// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:starting_project/core/errors/exceptions.dart';

abstract class Failure {
  final String message;
  final int statusCode;
  const Failure({required this.message, required this.statusCode});

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;

    return other.message == message && other.statusCode == statusCode;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  ApiFailure.fromException(APIException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
