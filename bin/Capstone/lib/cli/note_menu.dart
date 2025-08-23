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
  print("5. Stream Notes");
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
    case '5':
      await stremOfNotes(repository);
      return false;
    case '0':
      return true;
    default:
      return false;
  }
}

Future<Note> createNoteMenu(NoteRepository repository) async {
  try {
    String title = askBy("Write the note title: ");
    String body = askBy("Write the content of the note: ");

    List<Note> loadedNotes = await repository.loadNotes();

    while (title.isEmpty || body.isEmpty) {
      if (title.isEmpty) title = askBy("Write the note title: ");
      if (body.isEmpty) body = askBy("Write the content of the note: ");
    }

    final note = Note(
      id: getNextId(loadedNotes),
      title: title,
      body: body,
      createdAt: DateTime.now().toIso8601String(),
    );

    loadedNotes.add(note);
    await repository.saveNotes(loadedNotes);

    return note;
  } catch (e, st) {
    print("Error creating note: $e");
    print(st);
    return Note(id: 0, title: "Error", body: "", createdAt: DateTime.now().toIso8601String());
  }
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

Future<void> fetchDataRemote(NoteRepository repository) async {
  try {
    final loadedNotes = await repository.fetchRemoteNotes();
    await printNotes(loadedNotes, "Notes List From Remote");

    stdout.write("Can you save these notes in Local Storage? Y/N: ");
    final option = stdin.readLineSync();

    if (option == "Y" || option == "y") {
      await repository.syncWithRemote();
    } else {
      print("Notes not saved...");
    }
  } catch (e, st) {
    print("Error fetching notes from remote: $e");
    print(st);
  }
}


Future<void> pushDataRemote(NoteRepository repository) async {
  //Send all notes to remote
  try {
    final loadedNotes = await repository.loadNotes();
    String strNotes = await repository.sendNotes(loadedNotes);

     if (strNotes.isEmpty) {
      print("Error sending notes");
      return;
    }

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
  } catch (e, st) {
    print("Error sending notes to remote: $e");
    print(st);
  }
}

Future<void> stremOfNotes(NoteRepository repository) async {
  try {
    final notes = await repository.loadNotes();

    if (notes.isEmpty) {
      print("No nothes to stream");
    }

    //Make a Stream that emit a note every second
    Stream<Note> noteStream = Stream<Note>.fromIterable(notes)
    .asyncMap((note) async {
      await Future.delayed(Duration(seconds:1));
      return note;
    });

    //Lisen the stream and print every note
    await for (var note in noteStream) {
      print("ID: ${note.id}");
      print("Title: ${note.title}");
      print("Body: ${note.body}");
      print("Created at: ${note.createdAt}");
      print(" --------------------- ");
    }
  } on Error catch (e, st) {
    print("Error streaming notes: $e");
    print(st);
  }

}