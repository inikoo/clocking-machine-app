part of 'staff_auth_init_bloc.dart';

@immutable
abstract class StaffAuthInitState {}

class LoadingState extends StaffAuthInitState {}

class ScanningNfcState extends StaffAuthInitState {}

class ShowPinCodeEntryState extends StaffAuthInitState {}

class PreviewDataState extends StaffAuthInitState {
  final String data;
  final bool nfc;
  final Staff staff;

  PreviewDataState({
    this.nfc,
    this.data,
    this.staff,
  });
}

class ErrorState extends StaffAuthInitState {
  final String message;

  ErrorState(this.message);
}

class SuccessState extends StaffAuthInitState {
  final String message;

  SuccessState(this.message);
}
