part of 'staff_auth_init_bloc.dart';

@immutable
abstract class StaffAuthInitEvent {}

class InitialNfcEvent extends StaffAuthInitEvent {
  final Staff staff;
  final String deviceName;

  InitialNfcEvent({
    this.staff,
    this.deviceName,
  });
}

class InitialPinCodeEvent extends StaffAuthInitEvent {
  final Staff staff;
  final String deviceName;

  InitialPinCodeEvent({
    this.staff,
    this.deviceName,
  });
}

class SetPinCodeEvent extends StaffAuthInitEvent {
  final String pinCode;

  SetPinCodeEvent(this.pinCode);
}

class ConfirmDataEvent extends StaffAuthInitEvent {}
