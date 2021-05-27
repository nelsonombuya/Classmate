import 'dart:convert';

import 'package:equatable/equatable.dart';

class CourseDetails extends Equatable {
  final String? id;
  final String? name;
  final Map<String, dynamic>? units;

  const CourseDetails({
    this.id,
    this.name,
    this.units,
  });

  CourseDetails copyWith({
    String? id,
    String? name,
    Map<String, dynamic>? units,
  }) {
    return CourseDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      units: units ?? this.units,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'units': units,
    };
  }

  factory CourseDetails.fromMap(Map<String, dynamic> map) {
    return CourseDetails(
      id: map['id'],
      name: map['name'],
      units: Map<String, dynamic>.from(map['units'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseDetails.fromJson(String source) =>
      CourseDetails.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id ?? 'No Course ID Set',
        name ?? 'No Course Name Set',
        units ?? 'No Units Created',
      ];
}
