import '../lib/repositories/note_repository.dart';
import '../lib/services/storage_manager.dart';
import '../lib/cli/note_menu.dart';
import 'dart:io';
import '../lib/models/note.dart';

void main() async{
  final StorageManager storage = StorageManager("storage");
  final NoteRepository noteRepository = NoteRepository(storage);

  bool exit = false;
  while (!exit) {
    exit = await showMenu(noteRepository);
  }
}
