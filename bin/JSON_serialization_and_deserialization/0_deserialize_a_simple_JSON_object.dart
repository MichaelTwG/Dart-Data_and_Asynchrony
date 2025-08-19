
class User {
  final int id;
  final String name, email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
  );
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