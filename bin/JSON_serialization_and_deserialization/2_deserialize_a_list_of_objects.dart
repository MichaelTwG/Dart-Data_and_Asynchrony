import '1_serialize_a_dart_object_to_JSON.dart';
import 'dart:convert';

List<User> parseUsers(String jsonStr) {
  final List<dynamic> parsedJSON = jsonDecode(jsonStr);
  final List<User> users = parsedJSON.map((json) => User.fromJson(json)).toList();

  return users;
}

void main() {
  String usersJson = '''
  [
    {"id":1, "name":"Alice Johnson", "email":"alice.johnson@example.com"},
    {"id":2, "name":"Bob Smith", "email":"bob.smith@example.com"},
    {"id":3, "name":"Charlie Brown", "email":"charlie.brown@example.com"},
    {"id":4, "name":"Diana Prince", "email":"diana.prince@example.com"},
    {"id":5, "name":"Ethan Hunt", "email":"ethan.hunt@example.com"}
  ]
  ''';

  List<User> users = parseUsers(usersJson);

  users.forEach((usr) {
    print("userID: ${usr.id}\nuserName: ${usr.name}\nuserEmail: ${usr.email}\n");
  });

}