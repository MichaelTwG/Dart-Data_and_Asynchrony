import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String,String>> fetchPost() async{
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  Map<String,String> data;

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        "User-Agent" : 'Dart/3.1.3'
      },
    );
    if(response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      data = {
        'title': parsed['title'],
        'body': parsed['body'],
      };
      return data;
    } else {
      return {
      'title': 'Unavailable',
      'body': 'Error fetching post',
      };
    }
  } on SocketException catch (e) {
    print(e);
    return {
      'title': 'Unavailable',
      'body': 'No Internet',
    };
  } on FormatException catch (e) {
    print(e);
    return {
      'title': 'Unavailable',
      'body': 'Bad JSON format',
    };
  } on HttpException catch (e) {
    print(e);
    return {
      'title': 'Unavailable',
      'body': 'Invalid HTTP request',
    };
  } catch (e) {
    print(e);
    return {
      'title': 'Unavailable',
      'body': 'Unexpected error',
    };
  }

}

void main() async{
  Map<String,String> data = await fetchPost();
  print(data);
}