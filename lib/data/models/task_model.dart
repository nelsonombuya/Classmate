import 'dart:convert';

class TaskModel {
  String? docId;
  String title;
  bool isDone;
  TaskModel({
    this.docId,
    required this.title,
    required this.isDone,
  });

  TaskModel copyWith({
    String? docId,
    String? title,
    bool? isDone,
  }) {
    return TaskModel(
      docId: docId ?? this.docId,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'title': title,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      docId: map['docId'],
      title: map['title'],
      isDone: map['isDone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'TaskModel(docId: $docId, title: $title, isDone: $isDone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.docId == docId &&
        other.title == title &&
        other.isDone == isDone;
  }

  @override
  int get hashCode => docId.hashCode ^ title.hashCode ^ isDone.hashCode;
}
