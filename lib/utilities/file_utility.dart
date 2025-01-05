import 'dart:io';
import 'package:path/path.dart' as path;

class FileUtility {
  final String databaseFolder;

  FileUtility(this.databaseFolder);
  Future<String> getDatabaseFolder() async => await getFolder(databaseFolder, "Data");
  Future<String> getCommonDatabaseFolder() async => await getFolder(await getDatabaseFolder(), "Common");

  Future<String> getFolder(String path1, [String? path2, String? path3, String? path4, String? path5]) async {
    var p = path.join(path1, path2, path3, path4, path5);
    await createFolder(p);
    return p;
  }

  Future createFolder(String path) async {
    var dir = Directory(path);
    await dir.create(recursive: true);
  }
}
