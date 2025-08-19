import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> getJsonResponse(String url) async {
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "User-Agent" : 'Dart/3.1.3'
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load JSON data: statusCode = ${response.statusCode}");
    }

  } catch (e) {
    print(e);
    return {};
  }
}

Future<void> main() async {
  final post = await getJsonResponse('https://jsonplaceholder.typicode.com/posts/1');
  print("Title: ${post['title']}");
  print("Body: ${post['body']}");

}