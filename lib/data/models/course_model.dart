import 'dart:convert';

import 'package:flutter/foundation.dart';

class CourseModel {
  String? name;
  List<String>? sessions;
  Map<String, List<Map<String, dynamic>>>? units;
  CourseModel({
    this.name,
    this.sessions,
    this.units,
  });

  CourseModel copyWith({
    String? name,
    List<String>? sessions,
    Map<String, List<Map<String, dynamic>>>? units,
  }) {
    return CourseModel(
      name: name ?? this.name,
      sessions: sessions ?? this.sessions,
      units: units ?? this.units,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sessions': sessions,
      'units': units,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      name: map['name'],
      sessions: List<String>.from(map['sessions']),
      units: Map<String, List<Map<String, dynamic>>>.from(map['units']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CourseModel(name: $name, sessions: $sessions, units: $units)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseModel &&
        other.name == name &&
        listEquals(other.sessions, sessions) &&
        mapEquals(other.units, units);
  }

  @override
  int get hashCode => name.hashCode ^ sessions.hashCode ^ units.hashCode;
}
