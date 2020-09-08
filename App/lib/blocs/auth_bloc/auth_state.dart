part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class LoadingAuthState extends AuthState {}

class LoginPageAuthState extends AuthState {
  final String error;

  LoginPageAuthState({this.error = ""});
}

class HomePageAuthState extends AuthState {
  final User user;

  HomePageAuthState(this.user);
}
