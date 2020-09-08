part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final String deviceName;

  LoginAuthEvent({this.deviceName});
}

class LogoutAuthEvent extends AuthEvent {}
