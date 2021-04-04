import 'package:meta/meta.dart';
class Task {
  int id;
  String title;
  String description;
  final DateTime createdAt;
  DateTime updatedAt;
  bool isComplete;

  Task(
      {@required this.id,
      @required this.title,
      @required this.createdAt,
      this.description,
      this.updatedAt,
      this.isComplete = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'], title: json['title'], updatedAt: json['updatedAt'], description: json['description'], isComplete: json['isComplete'], createdAt: json['createdAt']);
  }
  dynamic toJson() => {'id': id, 'title': title, 'description': description};
}
