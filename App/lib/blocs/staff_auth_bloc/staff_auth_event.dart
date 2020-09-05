part of 'staff_auth_bloc.dart';

@immutable
abstract class StaffAuthEvent {}

class ReadNfcEvent extends StaffAuthEvent {}

class ManualAuthEvent extends StaffAuthEvent {}

class SetManualAuthEvent extends StaffAuthEvent {
  final String pinCode;

  SetManualAuthEvent(this.pinCode);
}

class InActionEvent extends StaffAuthEvent {}

class OutActionEvent extends StaffAuthEvent {}
