part of 'staff_bloc.dart';

@immutable
abstract class StaffEvent {}

class LoadStaffEvent extends StaffEvent {
  final String deviceName;

  LoadStaffEvent({this.deviceName});
}
