import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starting_project/core/errors/exceptions.dart';
import 'package:starting_project/core/errors/failure.dart';
import 'package:starting_project/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:starting_project/src/authentication/data/repositories/authentication_remote_data_source_implementation.dart';
import 'package:starting_project/src/authentication/domain/entities/user.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRemoteDataSourceImplementation repositoryImplementation;
  const String createdAt = 'string.createdAt';
  const String name = 'string.name';
  const String avatar = 'string.avatar';
  const testException = APIException(
    message: 'Unknown Error Occurred',
    statusCode: 500,
  );
  setUp(() {
    remoteDataSource = MockAuthenticationRemoteDataSource();
    repositoryImplementation =
        AuthenticationRemoteDataSourceImplementation(remoteDataSource);
  });
  group('createuser', () {
    test(
        'should call the [RemoteDataSource.createUser] and complete'
        'successfully when the call is successful', () async {
      // Arrange
      when(
        () => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')),
      ).thenAnswer((_) async => Future.value(null));

      // Act
      final result = await repositoryImplementation.createuser(
          createdAt: createdAt, name: name, avatar: avatar);

      // Assert
      expect(result, const Right(null));
      verify(
        () => remoteDataSource.createUser(
            createdAt: createdAt, name: name, avatar: avatar),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
    test(
        'should return a [APIFailure] when call [createUser] to the remote source is unsuccessful',
        () async {
      // Arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(
            named: 'createdAt',
          ),
          name: any(
            named: 'name',
          ),
          avatar: any(
            named: 'avatar',
          ),
        ),
      ).thenThrow(testException);
      final result = await repositoryImplementation.createuser(
          createdAt: createdAt, name: name, avatar: avatar);
      expect(
          result,
          equals(Left(ApiFailure(
            message: testException.message,
            statusCode: testException.statusCode,
          ))));
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
  group('getUsers', () {
    test(
        'should call the [RemoteDataSource.getUsers] and return [List<User>]'
        'when call to remote source is successful', () async {
      when(() => remoteDataSource.getUsers()).thenAnswer((_) async => <User>[]);

      final result = await remoteDataSource.getUsers();

      expect(result, equals(<User>[]));

      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [APIFailure] when the call [getUsers] to [Remote Source]is unsuccessful',
        () async {
      // Arrange
      when(() => remoteDataSource.getUsers()).thenThrow(testException);

      final result = await repositoryImplementation.getUsers();
      expect(
          result,
          equals(Left(ApiFailure(
            message: testException.message,
            statusCode: testException.statusCode,
          ))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
