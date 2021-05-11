import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String? id;
  final String title;
  final bool isDone;

  const TaskModel({
    this.id,
    required this.title,
    required this.isDone,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      isDone: map['isDone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() => 'TaskModel(id: $id, title: $title, isDone: $isDone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.id == id &&
        other.title == title &&
        other.isDone == isDone;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ isDone.hashCode;

  static const empty = TaskModel(
    title: '-',
    isDone: false,
  );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id ?? '-', title, isDone];
}
