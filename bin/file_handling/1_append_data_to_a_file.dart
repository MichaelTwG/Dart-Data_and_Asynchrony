import 'dart:io';
import 'package:path/path.dart' as p;
import '4_handleErrors.dart';
import 'createDirectory.dart';

Future<void> appendLogEntry(String filePath, [String? entry]) async{
  entry ??= DateTime.now().toIso8601String();

  final dirPath = p.dirname(filePath);
  if (!await createDirectory(dirPath)) {
    print('Cannot append log because directory could not be created.');
    return;
  }
  try{
    final file = File(filePath);
    await file.writeAsString('$entry\n', mode: FileMode.append);
    print('Log entry appended: $entry');
  } on FileSystemException catch (e){
    handleFileSystemError(e);
  } catch (e) {
    handleGeneralError(e);
  }
}

void main() async{
  await appendLogEntry("storage/data.txt");
}
