part of 'staff_auth_bloc.dart';

@immutable
abstract class StaffAuthEvent {}

class ReadNfcEvent extends StaffAuthEvent {
  final String deviceName;

  ReadNfcEvent({this.deviceName});
}

class ManualAuthEvent extends StaffAuthEvent {
  final String deviceName;

  ManualAuthEvent({this.deviceName});
}

class SetManualAuthEvent extends StaffAuthEvent {
  final String pinCode;

  SetManualAuthEvent(this.pinCode);
}

class InActionEvent extends StaffAuthEvent {}

class OutActionEvent extends StaffAuthEvent {}
