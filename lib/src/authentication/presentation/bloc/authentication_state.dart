part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object?> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class GettingUsers extends AuthenticationState {
  const GettingUsers();
}

class UserCreated extends AuthenticationState {
  const UserCreated();
}

class UsersLoaded extends AuthenticationState {
  final List<User> users;
  const UsersLoaded(this.users);

  @override
  List<String> get props => users.map((user) => user.id).toList();
}

class AuthenticationError extends AuthenticationState {
  final String message;
  const AuthenticationError(this.message);

  @override
  List<String> get props => [message];
}
