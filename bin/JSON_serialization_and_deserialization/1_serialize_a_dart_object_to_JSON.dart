
class User {
  final int id;
  final String name, email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
  );

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

void main() {
  Map<String, dynamic> inputData = {
    "id": 1,
    "name": "Alice",
    "email": "alice@example.com",
  };

  User user = User.fromJson(inputData);

  print(user.toJson());
}