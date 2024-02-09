// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  final String createdAt;
  final String name;
  final String avatar;
  const CreateUserEvent({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  @override
  List<Object?> get props => [createdAt, name, avatar];
}

class GetUsersEvent extends AuthenticationEvent {
  const GetUsersEvent();
}
