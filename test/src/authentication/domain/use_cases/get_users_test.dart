import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starting_project/src/authentication/domain/entities/user.dart';
import 'package:starting_project/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:starting_project/src/authentication/domain/use_cases/get_users.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUsers useCase;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = GetUsers(repository);
  });

  const testResponse = [User.empty()];
  test(
      'should call the [AuthenticationRepository.getUsers] and return a List<User>',
      () async {
    // Arrange
    when(() => repository.getUsers())
        .thenAnswer((_) async => const Right(testResponse));

    // Act
    final result = await useCase();

    expect(result, equals(const Right<dynamic, List<User>>(testResponse)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
