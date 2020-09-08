import 'dart:async';
import 'dart:convert';

import 'package:ClockIN/const.dart';
// import 'package:ClockIN/graphql/g_queries.dart';
import 'package:ClockIN/data/staff/staff.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:http/http.dart' as http;

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffBloc() : super(StaffLoading());

  @override
  Stream<StaffState> mapEventToState(
    StaffEvent event,
  ) async* {
    if (event is LoadStaffEvent) {
      yield* _mapLoadStaffEvent(event);
    }
  }

  Stream<StaffState> _mapLoadStaffEvent(LoadStaffEvent event) async* {
    try {
      yield StaffLoading();

      final _data = {"get": "staff"};

      final _headers = {"x-api-key": "${event.deviceName}${Const.apiKey}"};

      Response _response = await Dio().post(
        Const.serverURL,
        queryParameters: _data,
        options: Options(headers: _headers),
      );

      if (_response.statusCode == 200) {
        var _resData = json.decode(_response.data);

        if (_resData["staff"] != null) {
          List<Staff> _staffs = [];
          for (var i in _resData["staff"]) {
            i["id"] = i["key"];
            _staffs.add(Staff.fromMap(i));
          }

          if (_staffs.length > 0) {
            yield StaffLoaded(_staffs);
          } else {
            yield StaffLoadedEmpty();
          }
        } else {
          yield StaffLoadedEmpty();
        }
      } else {
        yield StaffLoadedEmpty();
      }

      // final httpLink = HttpLink(uri: Const.graphqlURL);
      // final link = Link.from([httpLink]);
      // final GraphQLClient _graphQLClient =
      //     GraphQLClient(cache: InMemoryCache(), link: link);

      // final result = await _graphQLClient
      //     .query(QueryOptions(documentNode: gql(GQueries.getEmployees)));

      // if (!result.hasException) {
      //   List<Staff> _staffs = [];
      //   for (var i in result.data['employees']['data']) {
      //     _staffs.add(Staff.fromMap(i));
      //   }
      //   if (_staffs.length > 0) {
      //     yield StaffLoaded(_staffs);
      //   } else {
      //     yield StaffLoadedEmpty();
      //   }
      // } else {
      //   yield StaffLoadedEmpty();
      // }

    } catch (error) {
      print(error);
      yield StaffLoadedEmpty();
    }
  }
}
