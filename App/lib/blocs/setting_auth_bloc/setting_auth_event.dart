part of 'setting_auth_bloc.dart';

@immutable
abstract class SettingAuthEvent {}

class InitEvent extends SettingAuthEvent {
  final String deviceName;

  InitEvent(this.deviceName);
}

class AuthEvent extends SettingAuthEvent {
  final String pin;

  AuthEvent(this.pin);
}
