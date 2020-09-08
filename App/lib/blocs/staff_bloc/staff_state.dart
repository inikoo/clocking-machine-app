part of 'staff_bloc.dart';

@immutable
abstract class StaffState {}

class StaffLoading extends StaffState {}

class StaffLoaded extends StaffState {
  final List<Staff> staffs;

  StaffLoaded(this.staffs);
}

class StaffLoadedEmpty extends StaffState {}
