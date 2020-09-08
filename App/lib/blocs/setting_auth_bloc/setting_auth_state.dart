part of 'setting_auth_bloc.dart';

@immutable
abstract class SettingAuthState {}

class LoadingState extends SettingAuthState {}

class ShowAuthScreenState extends SettingAuthState {}

class SuccessState extends SettingAuthState {}

class ErrorState extends SettingAuthState {
  final String message;

  ErrorState(this.message);
}
