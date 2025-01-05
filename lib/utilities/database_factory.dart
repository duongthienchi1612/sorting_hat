import 'dart:io';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sorting_hat/dependencies.dart';
import 'package:sorting_hat/utilities/file_utility.dart';

import 'database_manager.dart';

class DatabaseFactory {
  final FileUtility fileUtility = injector.get<FileUtility>();

  Future initDatabase() async {
    await initLocalDatabase();
    await getMasterData();
  }

  Future<String> initLocalDatabase() async {
    final folderPath = await fileUtility.getCommonDatabaseFolder();
    final dbPath = join(folderPath, "master_data.db");
    log(dbPath);

    bool isExist = await File(dbPath).exists();
    if (!isExist) {
      await File(dbPath).create(recursive: true);
    }
    // copy database from asset to local
    final bytes = await rootBundle.load('assets/database/master_data.db');
    await File(dbPath).writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return dbPath;
  }

  Future<DatabaseManager> getMasterData() async {
    final folderPath = await fileUtility.getCommonDatabaseFolder();
    final filePath = join(folderPath, "master_data.db");
    final db = DatabaseManager(path: filePath);
    await db.open();
    return db;
  }
}
