// import 'package:ClockIN/const.dart';
import 'package:ClockIN/data/staff/staff.dart';
import 'package:ClockIN/data/staff/staff_in_out.dart';
import 'package:ClockIN/data/user/user.dart';
import 'package:ClockIN/graphql/g_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GActions {
  GraphQLClient _graphQLClient;

  GActions() {
    // final httpLink = HttpLink(uri: Const.graphqlURL);
    // final _link = Link.from([httpLink]);
    // _graphQLClient = GraphQLClient(cache: InMemoryCache(), link: _link);
  }

  Future<Staff> getStaffId({
    String nfc,
    String pinCode,
  }) async {
    try {
      String _query;
      String _propertyName;

      if (nfc != null) {
        _query = GQueries.staffByRfid(nfc);
        _propertyName = "staffByRfid";
      } else {
        _query = GQueries.staffByPinCode(pinCode);
        _propertyName = "staffByPinCode";
      }

      final result = await _graphQLClient.query(QueryOptions(
        documentNode: gql(_query),
      ));

      if (result.hasException) {
        return null;
      } else {
        return Staff.fromMap(result.data[_propertyName]);
      }
    } catch (_) {
      return null;
    }
  }

  Future<StaffInOut> setStaffInOut({
    String action,
    int staffId,
    bool fileAvailable,
    String imageFileName,
    var data,
  }) async {
    try {
      QueryResult result;
      final _time = DateTime.now().toString().split(".")[0];

      if (fileAvailable) {
        result = await _graphQLClient.mutate(MutationOptions(
          documentNode: gql(
            GQueries.setStaffInOutWithImage(
              action: action,
              fileAvailable: fileAvailable,
              imageFileName: imageFileName,
              staffId: staffId,
              time: _time,
            ),
          ),
          variables: data,
        ));
      } else {
        result = await _graphQLClient.mutate(MutationOptions(
          documentNode: gql(
            GQueries.setStaffInOut(
              action: action,
              fileAvailable: fileAvailable,
              imageFileName: imageFileName,
              staffId: staffId,
              time: _time,
            ),
          ),
        ));
      }

      if (!result.hasException) {
        return StaffInOut.fromMap(result.data["setStaffInOut"]);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  Future<User> loginUser({String username, String password}) async {
    try {
      final result = await _graphQLClient.mutate(MutationOptions(
        documentNode: gql(
          GQueries.loginUser(
            username: username,
            password: password,
          ),
        ),
      ));

      if (!result.hasException) {
        final data = result.data['login'];

        if (data != null && data['email'] != null) {
          return User.fromMap(data);
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

  // Future<bool> checkUser(User user) async {
  //   try {
  //     final result = await _graphQLClient.query(QueryOptions(
  //       documentNode: gql(
  //         GQueries.checkUser(
  //           id: user.id,
  //           username: user.username,
  //           email: user.email,
  //         ),
  //       ),
  //     ));

  //     if (!result.hasException) {
  //       final data = result.data['user'];

  //       if (data != null && user.name == data['name']) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (_) {
  //     return false;
  //   }
  // }
}
