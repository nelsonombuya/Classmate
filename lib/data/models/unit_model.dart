import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'assignment_model.dart';
import 'lesson_model.dart';
import 'unit_details_model.dart';

class Unit extends Equatable {
  final String? id;
  final String? sessionId;
  final UnitDetails? unitDetails;
  final List<Assignment>? assignments;
  final List<Lesson>? lessons;

  const Unit({
    this.id,
    required this.sessionId,
    required this.unitDetails,
    this.assignments,
    this.lessons,
  });

  Unit copyWith({
    String? id,
    String? sessionId,
    UnitDetails? unitDetails,
    List<Assignment>? assignments,
    List<Lesson>? lessons,
  }) {
    return Unit(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      unitDetails: unitDetails ?? this.unitDetails,
      assignments: assignments ?? this.assignments,
      lessons: lessons ?? this.lessons,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionId,
      'unitDetails': unitDetails?.toMap(),
      'assignments': assignments?.map((x) => x.toMap()).toList(),
      'lessons': lessons?.map((x) => x.toMap()).toList(),
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id'],
      sessionId: map['sessionId'],
      unitDetails: UnitDetails.fromMap(map['unitDetails'] ?? {}),
      assignments: List<Assignment>.from(
          map['assignments'].map((x) => Assignment.fromMap(x)) ?? {}),
      lessons: List<Lesson>.from(
          map['lessons']?.map((x) => Lesson.fromMap(x)) ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) => Unit.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id ?? 'No ID',
      sessionId ?? 'No Session Set',
      unitDetails ?? 'No Unit Details',
      assignments ?? 'No Added Assignments',
      lessons ?? 'No Added Lessons',
    ];
  }
}
