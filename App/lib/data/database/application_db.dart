import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class ApplicationDB {
  static final ApplicationDB _singelton = ApplicationDB._();

  static ApplicationDB get instance => _singelton;

  Completer<Database> _dbOpenCompleter;

  ApplicationDB._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }

    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationSupportDirectory();

    final dbPath = join(appDocumentDir.path, 'clockIN.db');

    final db = await databaseFactoryIo.openDatabase(dbPath);

    _dbOpenCompleter.complete(db);
  }
}
