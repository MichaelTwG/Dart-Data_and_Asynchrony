import 'dart:io';

Future<bool> createDirectory(String path) async{
  //return true if the directory was created and false if not
  try{
    final dir = Directory(path);
    if(!await dir.exists()){
      await dir.create(recursive: true);
      print('Directory created: $path');
    } else {
      print('Directory already exists: $path');
    }
    return true;
  } catch (e) {
    print('Error creating directory: $e');
    return false;
  }
}