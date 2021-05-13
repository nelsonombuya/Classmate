import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? course;
  final String? school;
  final String? year;
  final List<String>? registeredUnits;

  const UserDataModel({
    this.firstName,
    this.lastName,
    this.course,
    this.school,
    this.year,
    this.registeredUnits,
  });

  UserDataModel copyWith({
    String? firstName,
    String? lastName,
    String? course,
    String? school,
    String? year,
    List<String>? registeredUnits,
  }) {
    return UserDataModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      course: course ?? this.course,
      school: school ?? this.school,
      year: year ?? this.year,
      registeredUnits: registeredUnits ?? this.registeredUnits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'course': course,
      'school': school,
      'year': year,
      'registeredUnits': registeredUnits,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      course: map['course'],
      school: map['school'],
      year: map['year'],
      registeredUnits: List<String>.from(map['registeredUnits'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      "First Name: ${firstName ?? '-'}",
      "Last Name: ${lastName ?? '-'}",
      "School ID: ${school ?? '-'}",
      "Course ID: ${course ?? '-'}",
      "Year: ${year ?? '-'}",
      "Registered Units: ${registeredUnits ?? '-'}",
    ];
  }
}
