class Note{
  int id;
  String title;
  String body;
  String createdAt;

  Note({required this.id, required this.title, required this.body, required this.createdAt});

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json['id'] as int,
    title: json['title'] as String,
    body: json['body'] as String,
    createdAt: json['createdAt'] as String,
  );

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt,
    };
  }
}