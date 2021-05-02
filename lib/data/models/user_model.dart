import 'dart:convert';

class UserModel {
  String firstName;
  String lastName;
  List? registeredUnits;

  UserModel({
    required this.firstName,
    required this.lastName,
    this.registeredUnits,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    List? registeredUnits,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      registeredUnits: registeredUnits ?? this.registeredUnits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'registeredUnits': registeredUnits,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      registeredUnits: map['registeredUnits'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(firstName: $firstName, lastName: $lastName, registeredUnits: $registeredUnits)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.registeredUnits == registeredUnits;
  }

  @override
  int get hashCode =>
      firstName.hashCode ^ lastName.hashCode ^ registeredUnits.hashCode;
}
