import 'package:http/http.dart' as http;
import 'dart:convert';

Future<int> sendPost() async{
  final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        "title": "Hello",
        "body": "This is a test post",
        "userId": 1,
      })
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['id'];
    }
    return -1;
  } catch (e) {
    print(e);
    return -1;
  }
}

void main() async {
  final id = await sendPost();
  print("Post ID: $id");
}