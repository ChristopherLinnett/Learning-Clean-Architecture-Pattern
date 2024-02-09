import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starting_project/core/errors/failure.dart';
import 'package:starting_project/src/authentication/domain/entities/user.dart';
import 'package:starting_project/src/authentication/domain/use_cases/create_user.dart';
import 'package:starting_project/src/authentication/domain/use_cases/get_users.dart';
import 'package:starting_project/src/authentication/presentation/cubit/authentication_cubit.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  const testCreateUserParams = CreateUserParams.empty();
  const testApiFailure = ApiFailure(message: 'message', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(testCreateUserParams);
  });

  tearDown(() => cubit.close());

  test('initial state should be [AuthenticationInitial]', () async {
    expect(cubit.state, equals(const AuthenticationInitial()));
  });

  group('createUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreateUser, UserCreated] when successful',
      build: () {
        when(() => createUser(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
          createdAt: testCreateUserParams.createdAt,
          name: testCreateUserParams.name,
          avatar: testCreateUserParams.avatar),
      expect: () => const [
        CreatingUser(),
        UserCreated(),
      ],
      verify: (cubit) {
        verify(() => createUser(testCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [CreateUser, AuthenticationError] when unsuccessful',
        build: () {
          when(() => createUser(any())).thenAnswer(
            (_) async => const Left(testApiFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.createUser(
            createdAt: testCreateUserParams.createdAt,
            name: testCreateUserParams.name,
            avatar: testCreateUserParams.avatar),
        expect: () => [
              const CreatingUser(),
              AuthenticationError(testApiFailure.errorMessage)
            ],
        verify: (cubit) {
          verify(() => createUser(testCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });
  });

  group('getUsers', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUsers, UsersLoaded] when successful',
      build: () {
        when(() => getUsers()).thenAnswer(
          (_) async => const Right([User.empty()]),
        );
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => const [
        GettingUsers(),
        UsersLoaded([User.empty()]),
      ],
      verify: (cubit) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [GettingUsers, AuthenticationError] when unsuccessful',
        build: () {
          when(() => getUsers()).thenAnswer(
            (_) async => const Left(testApiFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => [
              const GettingUsers(),
              AuthenticationError(testApiFailure.errorMessage)
            ],
        verify: (cubit) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });
  });
}
