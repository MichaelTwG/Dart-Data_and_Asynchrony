import 'dart:io';
import 'package:path/path.dart' as p;
import '4_handleErrors.dart';

Future<bool> deleteLogFileIfExists(String path) async{
  final dirPath = p.dirname(path);

  if (!await Directory(dirPath).exists()) {
    return false;
  }

  final file = File(path);

  if (!await file.exists()) {
    return false;
  }

  try{
    await file.delete();
    return true;
  } on FileSystemException catch (e) {
    handleFileSystemError(e);
    return false;
  } catch (e) {
    handleGeneralError(e);
    return false;
  }
}

void main() async {
  if (await deleteLogFileIfExists('storage/data.txt')) {
    print('Log file deleted successfully.');
  } else {
    print('Log file not found or could not be deleted.');
  }
}