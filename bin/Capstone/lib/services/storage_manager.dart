import 'package:path/path.dart' as p;
import 'dart:io';

class StorageManager {
  final String _dirPath;

  StorageManager(this._dirPath);
  String get dirPath => _dirPath;
  Directory get storageDir => Directory(_dirPath);

  Future<bool> createDirectory() async{
    return await handleExceptions(() async {
      if (!await storageDir.exists()) {
        await storageDir.create(recursive: true);
      }
    }) ?? false;
  }

  Future<bool> deleteDirectory() async {
    return await handleExceptions(() async {
      if (await storageDir.exists()) {
        await storageDir.delete(recursive:true);
      }
      return true;
    }) ?? false;
  }

  writeFile(String fileName, String content, {bool append = false}) async {
    return await handleExceptions(() async {
      final filePath = p.join(dirPath, fileName);
      final file = File(filePath);

      final sink = file.openWrite(
        mode: append ? FileMode.append : FileMode.write,
      );

      sink.write(content);
      await sink.flush();
      await sink.close();

      return true;
    }) ?? false;
  }

  Future<String?> readFile(String fileName) async {
    return await handleExceptions(() async {
      final filePath = p.join(dirPath, fileName);
      final file = File(filePath);
      if (!await file.exists()) return '';
      return await file.readAsString();
    });
  }

}

Future<T?> handleExceptions<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on FileSystemException catch (e) {
    print('File or directory error: ${e.message}');
    print('Affected path: ${e.path}');
    return null;
  } catch (e) {
    print('An unexpected error occurred: $e');
    return null;
  }
}