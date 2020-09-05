part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final String username;
  final String password;
  final String deviceName;

  LoginAuthEvent({
    this.username,
    this.password,
    this.deviceName,
  });
}

class LogoutAuthEvent extends AuthEvent {}
