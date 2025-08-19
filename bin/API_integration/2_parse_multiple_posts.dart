import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> fetchPostTitles() async{
  final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

  try {
    final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      "User-Agent" : 'Dart/3.1.3'
      },
    );

    if(response.statusCode == 200) {
      final List<dynamic> parsed = jsonDecode(response.body);
      List<String> titles = parsed.map((post) => (post as Map<String, dynamic>)['title'] as String).toList();
      return titles;
    }
    return [];
  } catch (e) {
    print(e);
    return [];
  }
}

void main() async {
  final list = await fetchPostTitles();
  for (final title in list) {
    print(title);
  }

  print("Titles count: ${list.length}" );
}