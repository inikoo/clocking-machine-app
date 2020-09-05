import 'dart:async';
import 'dart:convert';

import 'package:ClockIN/const.dart';
import 'package:ClockIN/data/user/user.dart';
import 'package:ClockIN/data/user/user_dao.dart';
// import 'package:ClockIN/graphql/g_actions.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LoadingAuthState());

  User _user;
  UserDao _userDao = UserDao();
  // GActions _actions = GActions();

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

      // User user = await _userDao.getUser();

      // if (user != null && user.username != null || user.username != "") {
      //   final _checkUser = await _actions.checkUser(user);

      //   if (_checkUser) {
      //     _user = user;
      //     yield HomePageAuthState(user);
      //   } else {
      //     yield LoginPageAuthState();
      //   }
      // } else {
      yield LoginPageAuthState();
      // }
    } catch (_) {
      yield (LoginPageAuthState());
    }
  }

  Stream<AuthState> _mapLoginAuthEvent(LoginAuthEvent event) async* {
    try {
      final _data = {
        "handle": event.username,
        "password": event.password,
        "device_name": event.deviceName,
        "role": "clocking-machine",
      };

      final _headers = {
        "Accept": "application/json",
      };

      var _response = await http.post(
        Const.authURL,
        headers: _headers,
        body: _data,
      );

      if (_response.statusCode == 200) {
        var _resData = json.decode(_response.body);

        _user = User(
          id: int.parse(_resData[0]["clockingMachine"]["id"].toString()),
          username: event.username,
          deviceName: event.deviceName,
          token: _resData[0]["token"].toString(),
        );

        yield HomePageAuthState(_user);
        await _initUserData(_user);
      } else if (_response.statusCode == 422) {
        var _resData = json.decode(_response.body);

        if (_resData["errors"]["email"] != null) {
          yield LoginPageAuthState(error: "Incorrect Username or Password!");
        } else if (_resData["errors"]["device_name"] != null) {
          yield LoginPageAuthState(error: "Duplicated device name!");
        } else {
          yield LoginPageAuthState(error: "Something went wrong!");
        }
      }
    } catch (_) {
      yield LoginPageAuthState(error: "Something went wrong!");
    }
  }

  Stream<AuthState> _mapLogoutAuthEvent() async* {
    yield LoginPageAuthState();
  }

  Future<void> _initUserData(User user) async {
    _user = user;
    await _userDao.delete();
    await _userDao.insert(_user);
  }
}
