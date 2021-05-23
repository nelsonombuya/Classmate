import 'dart:convert';

import 'package:equatable/equatable.dart';

class CourseDetails extends Equatable {
  final String? name;
  final Map<String, dynamic>? units;

  const CourseDetails({
    this.name,
    this.units,
  });

  CourseDetails copyWith({
    String? name,
    Map<String, dynamic>? units,
  }) {
    return CourseDetails(
      name: name ?? this.name,
      units: units ?? this.units,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'units': units,
    };
  }

  factory CourseDetails.fromMap(Map<String, dynamic> map) {
    return CourseDetails(
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
  List<Object> get props => [name ?? 'No Name', units ?? 'No Units'];
}
