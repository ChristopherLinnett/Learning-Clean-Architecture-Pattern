// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:starting_project/core/use_case/use_case.dart';
import 'package:starting_project/core/utils/typedef.dart';
import 'package:starting_project/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _repository;
  const CreateUser(this._repository);

  @override
  ResultFuture<void> call(CreateUserParams params) async =>
      _repository.createuser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams {
  final String createdAt;
  final String name;
  final String avatar;
  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const CreateUserParams.empty()
      : this(
            createdAt: '_empty.string',
            name: '_empty.string',
            avatar: '_empty.string');

  @override
  bool operator ==(covariant CreateUserParams other) {
    if (identical(this, other)) return true;

    return other.createdAt == createdAt &&
        other.name == name &&
        other.avatar == avatar;
  }

  @override
  int get hashCode => createdAt.hashCode ^ name.hashCode ^ avatar.hashCode;
}
