part of 'staff_auth_init_bloc.dart';

@immutable
abstract class StaffAuthInitEvent {}

class InitialNfcEvent extends StaffAuthInitEvent {
  final Staff staff;

  InitialNfcEvent(this.staff);
}

class InitialPinCodeEvent extends StaffAuthInitEvent {
  final Staff staff;

  InitialPinCodeEvent(this.staff);
}

class SetPinCodeEvent extends StaffAuthInitEvent {
  final String pinCode;

  SetPinCodeEvent(this.pinCode);
}

class ConfirmDataEvent extends StaffAuthInitEvent {}
