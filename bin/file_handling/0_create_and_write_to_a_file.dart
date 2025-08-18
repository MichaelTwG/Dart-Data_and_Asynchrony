import 'dart:io';
import 'package:path/path.dart' as p;
import 'createDirectory.dart';

Future<void> initializeLogFile(String filePath) async {
  final dirPath = p.dirname(filePath);
  await createDirectory(dirPath);
  
  try {
    final file = File(filePath);

    if (!await file.exists()) { //if exists dont override the file
      await file.writeAsString('User activity log initialized');
      print('Log file was create: ${file.path}');
    } else {
      print('Log file already exists: ${file.path}');
    }
  } catch (e) {
    print('Error initializing log file: $e');
  }
}

void main() {
  initializeLogFile("storage/data.txt");
}