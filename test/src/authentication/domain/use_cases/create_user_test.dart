// What does the class depend on ---> AuthenticationRepository
// How can we create a fake version of the dependency ---> Use Mocktail
// How do we control what our dependencies do ---> Using Mocktail API

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starting_project/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:starting_project/src/authentication/domain/use_cases/create_user.dart';

import 'authentication_repository.mock.dart';

void main() {
  late CreateUser useCase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = CreateUser(repository);
  });
  const params = CreateUserParams.empty();
  test(
    'should call the [AuthenticationRepository.createUser] method',
    () async {
      // Arrange

      // STUB
      when(() => repository.createuser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          )).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => repository.createuser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar)).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
