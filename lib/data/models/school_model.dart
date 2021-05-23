import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'course_details_model.dart';
import 'session_details_model.dart';
import 'unit_details_model.dart';

class School extends Equatable {
  final String? id;
  final String? name;
  final List<UnitDetails>? units;
  final List<CourseDetails>? courses;
  final List<SessionDetails>? sessions;

  const School({
    this.id,
    this.name,
    this.units,
    this.courses,
    this.sessions,
  });

  School copyWith({
    String? id,
    String? name,
    List<UnitDetails>? units,
    List<CourseDetails>? courses,
    List<SessionDetails>? sessions,
  }) {
    return School(
      id: id ?? this.id,
      name: name ?? this.name,
      units: units ?? this.units,
      courses: courses ?? this.courses,
      sessions: sessions ?? this.sessions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'units': units?.map((x) => x.toMap()).toList(),
      'courses': courses?.map((x) => x.toMap()).toList(),
      'sessions': sessions?.map((x) => x.toMap()).toList(),
    };
  }

  factory School.fromMap(Map<String, dynamic> map) {
    return School(
      id: map['id'],
      name: map['name'],
      units: List<UnitDetails>.from(
          map['units']?.map((x) => UnitDetails.fromMap(x)) ?? []),
      courses: List<CourseDetails>.from(
          map['courses']?.map((x) => CourseDetails.fromMap(x)) ?? []),
      sessions: List<SessionDetails>.from(
          map['sessions']?.map((x) => SessionDetails.fromMap(x)) ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory School.fromJson(String source) => School.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id ?? 'No ID',
      name ?? 'No Name',
      units ?? 'No Units',
      courses ?? 'No Courses',
      sessions ?? 'No Sessions',
    ];
  }
}
