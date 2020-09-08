import 'dart:convert';

import 'package:ClockIN/const.dart';
import 'package:ClockIN/util/system_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DeviceChecker {
  static Future<DeviceCheckResult> test({@required String deviceName}) async {
    try {
      if (deviceName != null && deviceName.trim() != "") {
        final _data = {"get": "staff"};
        final _headers = {"x-api-key": "$deviceName${Const.apiKey}"};

        Response _response = await Dio().post(
          Const.serverURL,
          queryParameters: _data,
          options: Options(headers: _headers),
        );

        if (_response.statusCode == 200) {
          var _resData = json.decode(_response.data);
          if (_resData["staff"] != null) {
            return DeviceCheckResult(
              error: false,
            );
          } else if (_resData["state"] == "Waiting" ||
              _resData["state"] == "Error") {
            return DeviceCheckResult(
              error: true,
              message: _resData["msg"] ?? SystemMessage.errSystemError,
            );
          } else {
            return DeviceCheckResult(
              error: true,
              message: SystemMessage.errSystemError,
            );
          }
        } else {
          return DeviceCheckResult(
            error: true,
            message: SystemMessage.errSystemError,
          );
        }
      } else {
        return DeviceCheckResult(
          error: true,
          message: SystemMessage.errSystemError,
        );
      }
    } catch (_) {
      return DeviceCheckResult(
        error: true,
        message: SystemMessage.errSystemError,
      );
    }
  }
}

class DeviceCheckResult {
  bool error;
  String message;

  DeviceCheckResult({
    @required this.error,
    this.message,
  });
}
