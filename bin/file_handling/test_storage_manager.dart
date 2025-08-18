import 'storage_manager.dart'; // Asegúrate de importar tu clase StorageManager aquí

void main() async {
  // Crear un StorageManager apuntando a una carpeta temporal
  final storage = StorageManager('example_storage');

  print('--- Creando directorio ---');
  bool dirCreated = await storage.createDirectory();
  print('Directorio creado: $dirCreated');

  print('\n--- Verificando si existe el directorio ---');
  bool dirExists = await storage.directoryExists(storage.dirPath);
  print('Directorio existe: $dirExists');

  print('\n--- Escribiendo archivos ---');
  bool file1Written = await storage.writeFile('file1.txt', 'Hola mundo!');
  bool file2Written = await storage.writeFile('file2.txt', 'Otro archivo\nSegunda línea.', append: true);
  print('Archivo file1.txt escrito: $file1Written');
  print('Archivo file2.txt escrito: $file2Written');

  print('\n--- Verificando si existen los archivos ---');
  bool file1Exists = await storage.fileExists('file1.txt');
  bool file2Exists = await storage.fileExists('file2.txt');
  print('file1.txt existe: $file1Exists');
  print('file2.txt existe: $file2Exists');

  print('\n--- Listando archivos en el directorio ---');
  final files = await storage.files;
  for (var file in files) {
    print('Archivo encontrado: ${storage.getFileName(file.path)}');
  }

  print('\n--- Borrando archivo file1.txt ---');
  bool file1Deleted = await storage.deleteFile('file1.txt');
  print('file1.txt eliminado: $file1Deleted');

  print('\n--- Listando archivos después de borrar file1.txt ---');
  final filesAfterDelete = await storage.files;
  for (var file in filesAfterDelete) {
    print('Archivo restante: ${storage.getFileName(file.path)}');
  }

  print('\n--- Borrando directorio completo ---');
  bool dirDeleted = await storage.deleteDirectory();
  print('Directorio eliminado: $dirDeleted');

  print('\n--- Verificando si el directorio aún existe ---');
  dirExists = await storage.directoryExists(storage.dirPath);
  print('Directorio existe: $dirExists');
}
