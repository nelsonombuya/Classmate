import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class CourseModel extends Equatable {
  final String? id;
  final String name;
  final Map<String, dynamic> units;

  const CourseModel({
    this.id,
    required this.name,
    required this.units,
  });

  CourseModel copyWith({
    String? id,
    String? name,
    Map<String, dynamic>? units,
  }) {
    return CourseModel(
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

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'],
      name: map['name'],
      units: Map<String, dynamic>.from(map['units']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id ?? '-', name, units];
}
