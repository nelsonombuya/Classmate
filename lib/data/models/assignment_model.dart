import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Assignment extends Equatable {
  final String title;
  final DateTime dueDate;
  final String? description;
  final Map<String, bool>? isDone;

  const Assignment({
    required this.title,
    required this.dueDate,
    this.isDone = const {},
    this.description,
  });

  Assignment copyWith({
    String? title,
    DateTime? dueDate,
    String? description,
    Map<String, bool>? isDone,
  }) {
    return Assignment(
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'description': description,
      'isDone': isDone,
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      title: map['title'],
      description: map['description'],
      isDone: Map<String, bool>.from(map['isDone'] ?? {}),
      dueDate: map['dueDate'] == null
          ? throw NullThrownError()
          : map['dueDate'] is Timestamp
              ? map['dueDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Assignment.fromJson(String source) =>
      Assignment.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        title,
        dueDate,
        description ?? 'No Description',
        isDone ?? 'No one has done the assignment',
      ];
}
