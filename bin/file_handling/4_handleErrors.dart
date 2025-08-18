import 'dart:io';

void handleFileSystemError(FileSystemException e){
  print('File or directory error: ${e.message}');
  print('Affected rute: ${e.path}');
}

void handleGeneralError(Object e) {
  print('An inexpected error occurred: $e');
}