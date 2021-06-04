import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String? id;
  final String title;
  final String type;
  final bool isDone;
  final DateTime? dueDate;
  final String? locationName;
  final double? locationLongitude;
  final double? locationLatitude;

  const TaskModel({
    this.id,
    required this.title,
    required this.type,
    required this.isDone,
    this.dueDate,
    this.locationName,
    this.locationLongitude,
    this.locationLatitude,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? type,
    bool? isDone,
    DateTime? dueDate,
    String? locationName,
    double? locationLongitude,
    double? locationLatitude,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      isDone: isDone ?? this.isDone,
      dueDate: dueDate ?? this.dueDate,
      locationName: locationName ?? this.locationName,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      locationLatitude: locationLatitude ?? this.locationLatitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'isDone': isDone,
      'locationName': locationName,
      'locationLongitude': locationLongitude,
      'locationLatitude': locationLatitude,
      'dueDate': dueDate?.millisecondsSinceEpoch,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      isDone: map['isDone'],
      locationName: map['locationName'],
      locationLatitude: map['locationLatitude'],
      locationLongitude: map['locationLongitude'],
      dueDate: map['dueDate'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
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
    type: 'Personal',
  );

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id ?? 'No Task ID',
      title,
      type,
      isDone,
      dueDate ?? 'No Due Date',
      locationName ?? 'No Location Details Set',
    ];
  }
}
