import 'dart:io';
import '4_handleErrors.dart';

Future<List<String>> readLogFile() async{

  try {
    final file = File('storage/data.txt');
    final lines = await file.readAsLines();
    return lines;
  } on FileSystemException catch (e) {
    handleFileSystemError(e);
    return [];
  } catch (e) {
    handleGeneralError(e);
    return [];
  }
}

void main() async{
  List<String> lines = await readLogFile();

  print(lines);
}