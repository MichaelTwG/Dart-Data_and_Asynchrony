import 'package:path/path.dart' as p;
import 'dart:io';

// The goal is to integrate everything known about storage into a class
class StorageManager {
  final String _dirPath;

  StorageManager(this._dirPath);
  String get dirPath => _dirPath;
  Directory get dir => Directory(_dirPath);

  //Handle Directories

  Future<bool> createDirectory() async{
    //Create a directory in a safe way, return true if successful otherwise false.
    return await handleExceptions(() async {
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      return true;
    }) ?? false;
  }

  Future<bool> deleteDirectory() async{
    //Delete a directory in a safe way, return true if successful otherwise false.
    return await handleExceptions(() async {
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
      return true;
    }) ?? false;
  }

  Future<bool> directoryExists(String dirPath) async{
    //Check if a directory exists and return true if it does otherwise false.
    return await handleExceptions(() async {
      final dir = Directory(dirPath);
      return await dir.exists();
    }) ?? false;
  }

  //Handle files

  Future<bool> writeFile(String fileName, String content, {bool append = false}) async{
    //Create and write a file in a safe way, return true if successful otherwise false.
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

  Future<bool> deleteFile(String fileName) async{
    //Delete a file in a safe way, return true if successful otherwise false.
    return await handleExceptions(() async {
      final filePath = p.join(dirPath, fileName);
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
      return true;
    }) ?? false;
  }

  Future<bool> fileExists(String fileName) async{
    //Check if a file exists and return true if it does otherwise false.
    return await handleExceptions(() async {
      final filePath = p.join(dirPath, fileName);
      final file = File(filePath);
      return await file.exists();
    }) ?? false;
  }

  Future<List<FileSystemEntity>> get files async {
    //Get files in _dirPath andr return a list of them.
    if (!await dir.exists()) return [];
    final entities = await dir.list().toList();
    return entities.whereType<File>().toList();
  }

  //Utilities

  String getFileName(String path) {
    //return only the file name from a complete path.
    return p.basename(path);
  }

  String getDirectoryPath(String path) {
    //return the directoryPath of a complete path.
    return p.dirname(path);
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