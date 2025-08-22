import 'dart:convert';
import 'dart:io';
import '../models/note.dart';
import '../repositories/note_repository.dart';

Future<bool> showMenu(NoteRepository repository) async{
  ///Display by console a menu with options to create a new note, view all notes, fetch data from remote and push data to remote
  print("\n=== Note Menu ===\n");
  print("1. Create a new note");
  print("2. View all notes");
  print("3. Fetch data from remote");
  print("4. Push data to remote");
  print("0. Exit");

  stdout.write("Choose an option: ");
  final option = stdin.readLineSync();

  switch (option) {
    case '1':
      await createNoteMenu(repository);
      return false;
    case '2':
      final loadedNotes = await repository.loadNotes();
      await printNotes(loadedNotes, "Notes List");
      return false;
    case '3':
      await fetchDataRemote(repository);
      return false;
    case '4':
      await pushDataRemote(repository);
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

Future<void> printNotes(List<Note> notes, String title) async{
  //Display all notes on the terminal

  print("\n=== $title ===\n");

  notes.forEach((note) {
    print("ID: ${note.id}");
    print("Title: ${note.title}");
    print("Body: ${note.body}");
    print("Created at: ${note.createdAt}");
    print(" --------------------- ");
  });
}

String askBy(String msg) {
  //Ask by console a message and return the response
  stdout.write(msg);
  final response = stdin.readLineSync() ?? "";
  return response;
}

int getNextId(List<Note> notes) {
  //Get the next id for a new note
  if (notes.isEmpty) return 1;
  return notes.map((n) => n.id).reduce((a, b) => a > b ? a : b) + 1;
}

Future<void> fetchDataRemote(NoteRepository repository) async{
  //Fetch all notes from remote
  final loadedNotes = await repository.fetchRemoteNotes();
  printNotes(loadedNotes, "Notes List From Remote");

  stdout.write("Can you save this notes en Local Storage? Y/N: ");
  final option = stdin.readLineSync();

  if (option == "Y" || option == "y") {
    await repository.syncWithRemote();
  } else {
    print("Notes not saved...");
  }
}

Future<void> pushDataRemote(NoteRepository repository) async {
  //Send all notes to remote
  final loadedNotes = await repository.loadNotes();
  String strNotes = await repository.sendNotes(loadedNotes);
  final parsedNotes = jsonDecode(strNotes);

  if (strNotes.isEmpty) {
    print("Error sending notes");
  } else {
    final List<Note> notes = parsedNotes.values.whereType<Map<String,dynamic>>()
    .map<Note>((note) => Note.fromJson({
      "id": note["id"] as int,
      "title": note["title"] as String,
      "body": note["body"] as String,
      "createdAt": note["createdAt"] as String,
    })).toList();

    printNotes(notes , "List of sended notes to remote");
  }
}