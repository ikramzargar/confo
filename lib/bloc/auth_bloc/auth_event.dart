import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final String email;
  final String password;

  const AuthLoggedIn(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthSignedUp extends AuthEvent {
  final String email;
  final String password;

  const AuthSignedUp(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthLoggedOut extends AuthEvent {}