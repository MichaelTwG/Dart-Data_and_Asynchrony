import '../lib/repositories/note_repository.dart';
import '../lib/services/storage_manager.dart';
import '../lib/cli/note_menu.dart';

void main() async {
  final StorageManager storage = StorageManager("storage");
  final NoteRepository noteRepository = NoteRepository(storage);

  bool exit = false;
  while (!exit) {
    try {
      exit = await showMenu(noteRepository);
    } catch (e, st) {
      print("An unexpected error occurred: $e");
      print(st);
    }
  }
}
