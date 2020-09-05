import 'package:ClockIN/data/database/application_db.dart';
import 'package:ClockIN/data/user/user.dart';
import 'package:sembast/sembast.dart';

class UserDao {
  static const String USER_STORE_NAME = 'user';

  final _userStore = intMapStoreFactory.store(USER_STORE_NAME);

  Future<Database> get _db async => await ApplicationDB.instance.database;

  Future insert(User user) async {
    await _userStore.add(await _db, user.toMap());
  }

  Future delete() async {
    await _userStore.delete(await _db);
  }

  Future<User> getUser() async {
    final recordSnapshot = await _userStore.findFirst(
      await _db,
    );

    return User.fromMap(recordSnapshot.value);
  }
}