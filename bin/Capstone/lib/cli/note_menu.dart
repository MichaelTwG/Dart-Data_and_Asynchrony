import 'dart:io';
import '../models/note.dart';
import '../repositories/note_repository.dart';

Future<bool> showMenu(NoteRepository repository) async{
  print("\n=== Note Menu ===\n");
  print("1. Create a new note");
  print("2. View all notes");
  print("0. Exit");

  stdout.write("Choose an option: ");
  final option = stdin.readLineSync();

  switch (option) {
    case '1':
      await createNoteMenu(repository);
      return false;
    case '2':
      await printNotes(repository);
      return false;
    case '0':
      return true;
    default:
      return false;
  }
}

Future<Note> createNoteMenu(NoteRepository repository) async{
  ///Display by console a mesage to the user asking for a title and a body and create a note
  String title = askBy("Write the note title: ");
  String body = askBy("Write the content of the note: ");

  //Load notes
  List<Note> loadedNotes = await repository.loadNotes();

  while (title == "" || body == "") {
    ///Ensures that title or body is not empty
    if (title == "") {
      title = askBy("Write the note title: ");
    } else if (body == "") {
      body = askBy("Write the content of the note: ");
    } else {
      break;
    }
  }

  //Create a new note
  final note = Note(
    id: getNextId(loadedNotes),
    title: title,
    body: body,
    createdAt: DateTime.now().toIso8601String(),
  );


  //Add the new note to the list
  loadedNotes.add(note);

  //Save the notes
  await repository.saveNotes(loadedNotes);

  return note;
}

Future<void> printNotes(NoteRepository repository) async{
  //Display all notes on the terminal

  print("\n=== Notes List===\n");
  final loadedNotes = await repository.loadNotes();

  loadedNotes.forEach((note) {
    print("ID: ${note.id}");
    print("Title: ${note.title}");
    print("Body: ${note.body}");
    print("Created at: ${note.createdAt}");
    print("---------------------");
  });
}

String askBy(String msg) {
  //Ask by console a message and return the response
  stdout.write(msg);
  final response = stdin.readLineSync() ?? "";
  return response;
}

int getNextId(List<Note> notes) {
  if (notes.isEmpty) return 1;
  return notes.map((n) => n.id).reduce((a, b) => a > b ? a : b) + 1;
}