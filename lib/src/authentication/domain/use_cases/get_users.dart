import 'package:starting_project/core/use_case/use_case.dart';
import 'package:starting_project/core/utils/typedef.dart';
import 'package:starting_project/src/authentication/domain/entities/user.dart';
import 'package:starting_project/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UseCaseWithoutParams<List<User>> {
  final AuthenticationRepository _repository;
  const GetUsers(this._repository);

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
