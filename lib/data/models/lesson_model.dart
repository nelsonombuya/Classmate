import 'dart:convert';

import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  final String title;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  const Lesson({
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
  });

  Lesson copyWith({
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Lesson(
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      title: map['title'],
      description: map['description'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) => Lesson.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        title,
        description ?? 'No Description',
        startDate,
        endDate,
      ];
}
