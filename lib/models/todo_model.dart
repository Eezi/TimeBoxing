import 'package:meta/meta.dart';

class Task {
  int id;
  final String title;
  final String description;
  bool isComplete;

  Task({@required this.id, @required this.title, this.description, this.isComplete = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'], title: json['title'], description: json['description']);
  }
  dynamic toJson() => {'id': id, 'title': title, 'description': description};
}