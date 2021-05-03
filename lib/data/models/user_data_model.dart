import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserDataModel {
  String? firstName;
  String? lastName;
  List<DocumentReference>? registeredUnits;
  DocumentReference? course;
  UserDataModel({
    this.firstName,
    this.lastName,
    this.registeredUnits,
    this.course,
  });

  UserDataModel copyWith({
    String? firstName,
    String? lastName,
    List<DocumentReference>? registeredUnits,
    DocumentReference? course,
  }) {
    return UserDataModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      registeredUnits: registeredUnits ?? this.registeredUnits,
      course: course ?? this.course,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'registeredUnits': registeredUnits,
      'course': course,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      registeredUnits: map['registeredUnits'].cast<DocumentReference>(),
      course: map['course'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDataModel(firstName: $firstName, lastName: $lastName, registeredUnits: $registeredUnits, course: $course)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDataModel &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        listEquals(other.registeredUnits, registeredUnits) &&
        other.course == course;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        registeredUnits.hashCode ^
        course.hashCode;
  }
}
