import 'dart:io';
import '4_handleErrors.dart';

Future<List<String>> listStorageFiles(String dirPath) async{
  final dir = Directory(dirPath);
  final files = <String>[];

  if (!await dir.exists()) {
    print("Directory doesn't exist");
    return files;
  }

  try {
    await for(var entity in dir.list(recursive: false, followLinks: false)){

      final type = await FileSystemEntity.type(entity.path);

      if (type == FileSystemEntityType.file){
        files.add(entity.uri.pathSegments.last);
      }
    }
    if (files.isEmpty) {
      print('The directory "$dirPath" is empty.');
    }
  } on FileSystemException catch (e) {
    handleFileSystemError(e);
  } catch (e) {
    handleGeneralError(e);
  }

  return files;
}

void main() async {
  final files = await listStorageFiles("storage");
  print(files);
}