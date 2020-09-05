part of 'staff_auth_bloc.dart';

@immutable
abstract class StaffAuthState {}

class LoadingState extends StaffAuthState {}

class ScanningNfcState extends StaffAuthState {}

class ShowManualAuthState extends StaffAuthState{}

class SelectActionState extends StaffAuthState {
  final Staff staff;

  SelectActionState(this.staff);
}

class ErrorState extends StaffAuthState {
  final String message;

  ErrorState(this.message);
}

class SuccessState extends StaffAuthState {
  final String message;

  SuccessState(this.message);
}
