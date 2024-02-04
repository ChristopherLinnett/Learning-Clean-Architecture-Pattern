import 'package:dartz/dartz.dart';
import 'package:starting_project/core/errors/exceptions.dart';
import 'package:starting_project/core/errors/failure.dart';
import 'package:starting_project/core/utils/typedef.dart';
import 'package:starting_project/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:starting_project/src/authentication/domain/entities/user.dart';
import 'package:starting_project/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRemoteDataSourceImplementation
    implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  const AuthenticationRemoteDataSourceImplementation(this._remoteDataSource);

  @override
  ResultVoid createuser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    // Test Driven Development
    // Call Remote Data Source
    // Check if method returns correct data
    // Check if the remote datasource throws exception,we return a failure
    // If it doesn't throw an exception, we return the expected data
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
