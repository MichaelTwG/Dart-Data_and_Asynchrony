import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name, email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

void main() {
  Map<String, dynamic> inputData = {
    "id": 1,
    "name": "Alice",
    "email": "alice@example.com",
  };

  User user = User.fromJson(inputData);

  print("ID: ${user.id}");
  print("Name: ${user.name}");
  print("Email: ${user.email}");
}