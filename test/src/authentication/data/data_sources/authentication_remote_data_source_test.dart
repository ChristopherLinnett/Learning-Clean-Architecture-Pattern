import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:starting_project/core/errors/exceptions.dart';
import 'package:starting_project/core/utils/constants.dart';
import 'package:starting_project/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:starting_project/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('createuser', () {
    test('should complete successfully when [statusCode] is 200 or 201',
        () async {
      when(() => client.post(any(),
          body: any(named: 'body'), headers: any(named: 'headers'))).thenAnswer(
        (_) async => http.Response(
          'User Created Successfully',
          201,
        ),
      );

      final methodCall = remoteDataSource.createUser;

      expect(
        methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
        completes,
      );

      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
          headers: any(named: 'headers'))).called(1);
      verifyNoMoreInteractions(client);
    });
    test('should throw [APIException] when the status code is not 200 or 201',
        () async {
      when(() => client.post(any(),
          body: any(named: 'body'), headers: any(named: 'headers'))).thenAnswer(
        (_) async => http.Response(
          'Invalid Email Address',
          400,
        ),
      );
      final methodCall = remoteDataSource.createUser;

      expect(
          () async => methodCall(
              createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          throwsA(const APIException(
            message: 'Invalid Email Address',
            statusCode: 400,
          )));

      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
          headers: any(named: 'headers'))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is 505', () async {
      when(() => client.post(any(),
          body: any(named: 'body'), headers: any(named: 'headers'))).thenAnswer(
        (_) async => http.Response('Dart Error', 505),
      );
      final methodCall = remoteDataSource.createUser;

      expect(
          () async => methodCall(
              createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          throwsA(const APIException(
            message: 'Dart Error',
            statusCode: 505,
          )));

      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
          headers: any(named: 'headers'))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
  group('getUsers', () {
    const testUsers = [UserModel.empty()];
    test('should return a [List<User>] when [statusCode] is 200', () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode([testUsers.first.toMap()]), 200),
      );

      final response = await remoteDataSource.getUsers();

      expect(
        response,
        equals(testUsers),
      );

      verify(() => client.get(
            Uri.https(kBaseUrl, kgetUsersEndpoint),
          )).called(1);
      verifyNoMoreInteractions(client);
    });
    final testMessage = jsonEncode('Server Down, Try again Later');
    test('should throw [APIException] when the status code is not 200',
        () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(testMessage, 500),
      );
      final methodCall = remoteDataSource.getUsers;

      expect(
          () async => methodCall(),
          throwsA(APIException(
            message: testMessage,
            statusCode: 500,
          )));

      verify(() => client.get(
            Uri.https(kBaseUrl, kgetUsersEndpoint),
          )).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
