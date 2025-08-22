import '../lib/repositories/note_repository.dart';
import '../lib/services/storage_manager.dart';
import '../lib/cli/note_menu.dart';

void main() async{
  final StorageManager storage = StorageManager("storage");
  final NoteRepository noteRepository = NoteRepository(storage);
  //await noteRepository.syncWithRemote();

  bool exit = false;
  while (!exit) {
    exit = await showMenu(noteRepository);
  }
}
