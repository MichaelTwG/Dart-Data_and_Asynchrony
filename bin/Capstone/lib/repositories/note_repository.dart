import '../services/storage_manager.dart';
import 'package:http/http.dart' as http;
import '../models/note.dart';
import 'dart:convert';

class NoteRepository {
  /// Repository to manage notes backups
  final StorageManager storage;

  final String fileName = 'notes.json'; /// Name of the file to store the notes
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts'; /// Api url to fetch notes

  NoteRepository(this.storage);

  Future<void> saveNotes(List<Note> notes) async {
    /// Save a list of notes in the Local Storage
    final jsonStr = jsonEncode(notes.map((note) => note.toJson()).toList());
    await storage.createDirectory();
    await storage.writeFile(fileName, jsonStr, append: false);
  }

  Future<List<Note>> loadNotes() async {
    /// Read the Local Storage and return a list of notes
    final content = await storage.readFile(fileName);
    if (content == null || content.trim().isEmpty) return [];
    final data = jsonDecode(content);
    if (data is! List) return [];

    return data.map((e) => Note
    .fromJson(e as Map<String, dynamic>))
    .toList();
  }


  Future<List<Note>> fetchRemoteNotes() async{
    /// Fetch remote notes of apiUrl and return a list of notes
    final url = Uri.parse(apiUrl);

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'Dart/3.1.3'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> parsed = jsonDecode(response.body);
        List<Note> notes = parsed.map((post) {
          post['createdAt'] = DateTime.now().toIso8601String(); // Add 'createdAt']
          return Note.fromJson(post as Map<String, dynamic>);
        }).toList();
        return notes;
      } else {
        return [];
      }
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<String> sendNotes(List<Note> notes) async {
    /// Send a list of notes to the apiUrl
    final url = Uri.parse(apiUrl);

    try {
      final sendData = jsonEncode(notes.map((note) => note.toJson()).toList());
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: sendData,
      );
      if (response.statusCode == 201) {
        return response.body;
      } else {
        return "";
      }
    } catch(e) {
      print(e);
      return "";
    }
  }

  Future<void> syncWithRemote() async {
    /// Sync the local notes with the remote notes
    final localNotes = await loadNotes();
    final remoteNotes = await fetchRemoteNotes();
    await sendNotes(localNotes);
    
    final Map<int, Note> notesById = {
      for (var note in remoteNotes) note.id: note,
      for (var note in localNotes) note.id: note,
    };
    final allNotes = notesById.values.toList();
    await saveNotes(allNotes);

  }
}