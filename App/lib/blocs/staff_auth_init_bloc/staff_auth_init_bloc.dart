import 'dart:async';
import 'dart:convert';

import 'package:ClockIN/const.dart';
import 'package:ClockIN/data/staff/staff.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
// import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'staff_auth_init_event.dart';
part 'staff_auth_init_state.dart';

class StaffAuthInitBloc extends Bloc<StaffAuthInitEvent, StaffAuthInitState> {
  StaffAuthInitBloc() : super(LoadingState());

  bool _nfc;
  Staff _staff;
  String _data;
  String _deviceName;

  @override
  Stream<StaffAuthInitState> mapEventToState(
    StaffAuthInitEvent event,
  ) async* {
    if (event is InitialNfcEvent) {
      yield* _mapInitialNfcEvent(event);
    } else if (event is InitialPinCodeEvent) {
      yield* _mapInitialPinCodeEvent(event);
    } else if (event is SetPinCodeEvent) {
      yield* _mapSetPinCodeEvent(event);
    } else if (event is ConfirmDataEvent) {
      yield* _mapConfirmDataEvent();
    }
  }

  Stream<StaffAuthInitState> _mapInitialNfcEvent(InitialNfcEvent event) async* {
    try {
      _deviceName = event.deviceName;
      if (event.staff != null) {
        _staff = event.staff;
        _nfc = true;
      } else {
        _nfc = false;
        yield ErrorState("Oops.. Something went wrong!");
        return;
      }

      yield ScanningNfcState();

      final nfcData = await FlutterNfcReader.read();

      if (nfcData != null) {
        _data = nfcData.id;
        yield PreviewDataState(
          nfc: true,
          data: nfcData.id,
          staff: _staff,
        );
      } else {
        yield ErrorState("No NFC tags identified!");
      }
    } catch (_) {
      yield ErrorState("Oops.. Something went wrong!");
    }
  }

  Stream<StaffAuthInitState> _mapInitialPinCodeEvent(
      InitialPinCodeEvent event) async* {
    try {
      _deviceName = event.deviceName;
      if (event.staff != null) {
        _staff = event.staff;
        yield ShowPinCodeEntryState();
      } else {
        yield ErrorState("Oops.. Something went wrong!");
      }
    } catch (_) {
      yield ErrorState("Oops.. Something went wrong!");
    }
  }

  Stream<StaffAuthInitState> _mapSetPinCodeEvent(SetPinCodeEvent event) async* {
    try {
      if (event.pinCode != null) {
        _data = event.pinCode;
        yield PreviewDataState(
          nfc: false,
          data: event.pinCode,
          staff: _staff,
        );
      } else {
        yield ErrorState("Oops.. Something went wrong!");
      }
    } catch (_) {
      yield ErrorState("Oops.. Something went wrong!");
    }
  }

  Stream<StaffAuthInitState> _mapConfirmDataEvent() async* {
    try {
      var data = {
        "staff_id": _staff.id,
        "set": _nfc ? "nfc" : "pin",
      };

      if (_nfc) {
        data["nfc"] = _data;
      } else {
        data["pin"] = _data;
      }

      final _headers = {"x-api-key": "$_deviceName${Const.apiKey}"};

      Response _response = await Dio().post(
        Const.serverURL,
        queryParameters: data,
        options: Options(headers: _headers),
      );

      if (_response.statusCode == 200) {
        var _resData = json.decode(_response.data);

        if (_resData["result"] != null) {
          String _message = _nfc ? "NFC " : "Pin code ";
          _message += "for ${_staff.name} updated!";
          yield SuccessState(_message);
        } else {
          yield ErrorState("Oops.. Something went wrong!");
        }
      } else {
        yield ErrorState("Oops.. Something went wrong!");
      }
    } catch (error) {
      print(error);
      yield ErrorState("Oops.. Something went wrong!");
    }
  }
}
