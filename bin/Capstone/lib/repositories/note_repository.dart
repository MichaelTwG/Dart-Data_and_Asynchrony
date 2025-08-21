import '../services/storage_manager.dart';
import 'package:http/http.dart' as http;
import '../models/note.dart';
import 'dart:convert';

class NoteRepository {
  final StorageManager storage;

  final String fileName = 'notes.json';
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  NoteRepository(this.storage);

  Future<void> saveNotes(List<Note> notes) async {
    final jsonStr = jsonEncode(notes.map((note) => note.toJson()).toList());
    await storage.createDirectory();
    await storage.writeFile(fileName, jsonStr, append: false);
  }

  Future<List<Note>> loadNotes() async {
    final content = await storage.readFile(fileName);
    if (content == null || content.trim().isEmpty) return [];
    final data = jsonDecode(content);
    if (data is! List) return [];

    return data.map((e) => Note
    .fromJson(e as Map<String, dynamic>))
    .toList();
  }


  Future<List<Note>> fetchRemoteNotes() async{
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
}