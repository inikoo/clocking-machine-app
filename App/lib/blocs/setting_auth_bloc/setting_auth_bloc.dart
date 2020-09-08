import 'dart:async';

import 'package:ClockIN/util/device_checker.dart';
import 'package:ClockIN/util/system_message.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'setting_auth_event.dart';
part 'setting_auth_state.dart';

class SettingAuthBloc extends Bloc<SettingAuthEvent, SettingAuthState> {
  SettingAuthBloc() : super(LoadingState());

  @override
  Stream<SettingAuthState> mapEventToState(
    SettingAuthEvent event,
  ) async* {
    if (event is InitEvent) {
      yield* _mapInitEvent(event);
    } else if (event is AuthEvent) {
      yield* _mapAuthEvent(event);
    }
  }

  Stream<SettingAuthState> _mapInitEvent(InitEvent event) async* {
    try {
      yield LoadingState();

      final _check = await DeviceChecker.test(deviceName: event.deviceName);

      if (!_check.error) {
        yield ShowAuthScreenState();
      } else {
        yield ErrorState(_check.message);
      }
    } catch (_) {
      yield ErrorState(SystemMessage.errSystemError);
    }
  }

  Stream<SettingAuthState> _mapAuthEvent(AuthEvent event) async* {
    try {
      if (event.pin != null && event.pin.trim() != "") {
        if (event.pin == "123456") {
          yield SuccessState();
        } else {
          yield ErrorState(SystemMessage.errSettingPinError);
        }
      } else {
        yield ErrorState(SystemMessage.errSystemError);
      }
    } catch (_) {
      yield ErrorState(SystemMessage.errSystemError);
    }
  }
}
