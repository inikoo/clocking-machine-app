import 'dart:async';
import 'dart:convert';
// import 'dart:io';

import 'package:ClockIN/const.dart';
import 'package:ClockIN/util/device_checker.dart';
import 'package:ClockIN/util/system_message.dart';
// import 'package:ClockIN/graphql/g_actions.dart';
import 'package:bloc/bloc.dart';
// import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:path/path.dart' show join;
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:meta/meta.dart';
import 'package:ClockIN/data/staff/staff.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:uuid/uuid.dart';

part 'staff_auth_event.dart';
part 'staff_auth_state.dart';

class StaffAuthBloc extends Bloc<StaffAuthEvent, StaffAuthState> {
  StaffAuthBloc() : super(LoadingState());

  Staff _staff;
  // String _imagePath;
  // CameraController _cameraController;
  // GActions _actions = GActions();
  bool _nfc;
  String _deviceName;

  @override
  Stream<StaffAuthState> mapEventToState(
    StaffAuthEvent event,
  ) async* {
    if (event is ReadNfcEvent) {
      yield* _mapReadNfcEvent(event);
    } else if (event is ManualAuthEvent) {
      yield* _mapInitManualAuthEventEvent(event);
    } else if (event is SetManualAuthEvent) {
      yield* _mapSetManualAuthEvent(event);
    } else if (event is InActionEvent) {
      yield* _mapInOutActionEvent(true);
    } else if (event is OutActionEvent) {
      yield* _mapInOutActionEvent(false);
    }
  }

  Stream<StaffAuthState> _mapReadNfcEvent(ReadNfcEvent event) async* {
    try {
      yield LoadingState();

      _deviceName = event.deviceName;
      final _check = await DeviceChecker.test(deviceName: event.deviceName);

      if (!_check.error) {
        yield ScanningNfcState();
        _nfc = true;

        // _imagePath = "";

        final nfcData = await FlutterNfcReader.read();

        if (nfcData != null) {
          // String _image = await _captureImage();
          // _imagePath = _image;

          // if (_image == null || _image == "") {
          //   yield ErrorState("Oops.. Something went wrong!");
          //   return;
          // }

          // _staff = await _actions.getStaffId(rfid: nfcData.id);
          _staff = await _checkStaff(nfc: nfcData.id);

          if (_staff != null) {
            yield SelectActionState(_staff);
          } else {
            yield ErrorState(SystemMessage.errNfcNotValid(nfcData.id));
          }
        } else {
          yield ErrorState(SystemMessage.errNfcNullError);
        }
      } else {
        yield ErrorState(_check.message);
      }
    } catch (_) {
      yield ErrorState(SystemMessage.errSystemError);
    }
  }

  Stream<StaffAuthState> _mapInitManualAuthEventEvent(
      ManualAuthEvent event) async* {
    try {
      yield LoadingState();

      _deviceName = event.deviceName;
      final _check = await DeviceChecker.test(deviceName: event.deviceName);

      if (!_check.error) {
        yield ShowManualAuthState();
      } else {
        yield ErrorState(_check.message);
      }
    } catch (_) {
      yield ErrorState(SystemMessage.errSystemError);
    }
  }

  Stream<StaffAuthState> _mapSetManualAuthEvent(
      SetManualAuthEvent event) async* {
    try {
      yield LoadingState();
      _nfc = false;

      // _imagePath = "";
      // _staff = await _actions.getStaffId(pinCode: event.pinCode);
      _staff = await _checkStaff(pinCode: event.pinCode);

      if (_staff != null) {
        yield SelectActionState(_staff);
      } else {
        yield ErrorState(SystemMessage.errPinCodeNotValid(event.pinCode));
      }
    } catch (_) {
      yield ErrorState(SystemMessage.errSystemError);
    }
  }

  Stream<StaffAuthState> _mapInOutActionEvent(bool inAction) async* {
    try {
      yield LoadingState();

      final action = inAction ? "in" : "out";
      // final fileAvailable = (_imagePath != null && _imagePath != "");
      var _data = {
        "source": _nfc ? "nfc" : "pin",
        "staff_id": _staff.id,
        "clocking": DateTime.now().toString().split(".")[0],
      };
      final _headers = {"x-api-key": "$_deviceName${Const.apiKey}"};

      Response response = await Dio().post(
        Const.serverURL,
        queryParameters: _data,
        options: Options(headers: _headers),
      );

      if (response.statusCode == 200) {
        yield SuccessState(SystemMessage.sucClockedSuccess(action));
      } else {
        yield ErrorState(SystemMessage.errSystemError);
      }

      // if (fileAvailable) {
      //   var byteData = File(_imagePath).readAsBytesSync();

      // var multipartFile = MultipartFile.fromBytes(
      //   'photo',
      //   byteData,
      //   filename: '${DateTime.now().second}.png',
      //   contentType: MediaType("image", "png"),
      // );

      // _data = {
      //   "image_file": multipartFile,
      // };
      // } else {
      //   _data = null;
      // }

      // final result = await _actions.setStaffInOut(
      //   staffId: _staff.id,
      //   action: action,
      //   fileAvailable: fileAvailable,
      //   imageFileName: Uuid().v4(),
      //   data: _data,
      // );

      // if (result != null) {
      //   yield SuccessState("You have registered as ${action.toUpperCase()}");
      // } else {
      //   yield ErrorState("Oops.. Something went wrong!");
      // }
    } catch (_) {
      yield ErrorState(SystemMessage.errSystemError);
    }
  }

  // Future<String> _captureImage() async {
  //   try {
  //     final cameras = await availableCameras();
  //     _cameraController = CameraController(
  //       cameras.last,
  //       ResolutionPreset.medium,
  //       enableAudio: false,
  //     );

  //     await _cameraController.initialize();

  //     final path =
  //         join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

  //     await _cameraController.takePicture(path);

  //     return path;
  //   } catch (_) {
  //   return null;
  //   }
  // }

  Future<Staff> _checkStaff({String nfc, String pinCode}) async {
    try {
      final _data = {"get": "staff"};
      final _headers = {"x-api-key": "$_deviceName${Const.apiKey}"};

      Response _response = await Dio().post(
        Const.serverURL,
        queryParameters: _data,
        options: Options(headers: _headers),
      );

      if (_response.statusCode == 200) {
        var _resData = json.decode(_response.data);

        if (_resData["staff"] != null) {
          Staff _selectedStaff;
          for (var i in _resData["staff"]) {
            i["id"] = i["key"];
            if (_nfc && i["nfc"] == nfc) {
              _selectedStaff = Staff.fromMap(i);
              break;
            } else if (!_nfc && i["pin"] == pinCode) {
              _selectedStaff = Staff.fromMap(i);
              break;
            }
          }

          if (_selectedStaff != null) {
            return _selectedStaff;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
