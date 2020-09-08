import 'dart:async';

import 'package:ClockIN/data/user/user.dart';
import 'package:ClockIN/data/user/user_dao.dart';
import 'package:ClockIN/util/system_message.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LoadingAuthState());

  User _user;
  UserDao _userDao = UserDao();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckAuthEvent) {
      yield* _mapCheckAuthEvent();
    } else if (event is LoginAuthEvent) {
      yield* _mapLoginAuthEvent(event);
    } else if (event is LogoutAuthEvent) {
      yield* _mapLogoutAuthEvent();
    }
  }

  Stream<AuthState> _mapCheckAuthEvent() async* {
    try {
      yield LoadingAuthState();

      User user = await _userDao.getUser();

      if (user != null && user.deviceName != null || user.deviceName != "") {
        yield HomePageAuthState(user);
      } else {
        yield LoginPageAuthState();
      }
    } catch (_) {
      yield (LoginPageAuthState());
    }
  }

  Stream<AuthState> _mapLoginAuthEvent(LoginAuthEvent event) async* {
    try {
      if (event.deviceName != null && event.deviceName.trim() != "") {
        User user = User(deviceName: event.deviceName);
        _initUserData(user);
        yield HomePageAuthState(user);
      } else {
        yield LoginPageAuthState(error: SystemMessage.errSystemError);
      }
    } catch (_) {
      yield LoginPageAuthState(error: SystemMessage.errSystemError);
    }
  }

  Stream<AuthState> _mapLogoutAuthEvent() async* {
    await _userDao.delete();
    yield LoginPageAuthState();
  }

  Future<void> _initUserData(User user) async {
    _user = user;
    await _userDao.delete();
    await _userDao.insert(_user);
  }
}
