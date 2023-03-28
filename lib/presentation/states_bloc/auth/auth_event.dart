part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnRegisterEvent extends AuthEvent {
  final UserModel user;

  const OnRegisterEvent(this.user);

  @override
  List<Object> get props => [user];
}

class OnLoginEvent extends AuthEvent {
  final UserModel user;

  const OnLoginEvent(this.user);

  @override
  List<Object> get props => [user];
}

class OnCurrentEvent extends AuthEvent {
  final String id;

  const OnCurrentEvent(this.id);

  @override
  List<Object> get props => [id];
}

class OnLogoutEvent extends AuthEvent {}
