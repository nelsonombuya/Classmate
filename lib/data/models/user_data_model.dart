import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'message_model.dart';

class UserData extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? courseId;
  final String? schoolId;
  final String? sessionId;
  final String? year;
  final String? semester;
  final String? privilege;
  final List<String>? registeredUnitIds;
  final List<NotificationMessage>? notifications;
  final String? deviceToken;

  const UserData({
    this.firstName,
    this.lastName,
    this.courseId,
    this.schoolId,
    this.sessionId,
    this.year,
    this.semester,
    this.privilege,
    this.registeredUnitIds,
    this.notifications,
    this.deviceToken,
  });

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? courseId,
    String? schoolId,
    String? sessionId,
    String? year,
    String? semester,
    String? privilege,
    List<String>? registeredUnitIds,
    List<NotificationMessage>? notifications,
    String? deviceToken,
  }) {
    return UserData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      courseId: courseId ?? this.courseId,
      schoolId: schoolId ?? this.schoolId,
      sessionId: sessionId ?? this.sessionId,
      year: year ?? this.year,
      semester: semester ?? this.semester,
      privilege: privilege ?? this.privilege,
      registeredUnitIds: registeredUnitIds ?? this.registeredUnitIds,
      notifications: notifications ?? this.notifications,
      deviceToken: deviceToken ?? this.deviceToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'courseId': courseId,
      'schoolId': schoolId,
      'sessionId': sessionId,
      'year': year,
      'semester': semester,
      'privilege': privilege,
      'registeredUnitIds': registeredUnitIds,
      'notifications': notifications?.map((x) => x.toMap()).toList(),
      'deviceToken': deviceToken,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      firstName: map['firstName'],
      lastName: map['lastName'],
      courseId: map['courseId'],
      schoolId: map['schoolId'],
      sessionId: map['sessionId'],
      year: map['year'],
      semester: map['semester'],
      privilege: map['privilege'],
      deviceToken: map['deviceToken'],
      registeredUnitIds: List<String>.from(map['registeredUnitIds'] ?? []),
      notifications: List<NotificationMessage>.from(
        map['notifications']?.map((x) => NotificationMessage.fromMap(x)) ?? [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      firstName ?? 'No First Name',
      lastName ?? 'No Last Name',
      courseId ?? 'No Registered Course',
      schoolId ?? 'No Registered SchoolID',
      sessionId ?? 'No Registered Session',
      semester ?? 'No Registered Semester',
      year ?? 'No Registered Year',
      privilege ?? 'User',
      deviceToken ?? 'No Device Token',
      registeredUnitIds ?? 'No Registered Units',
      notifications ?? 'No Notifications',
    ];
  }
}
