import 'dart:convert';

class UserModel {
  String uid;
  String? email;
  String? displayName;
  bool isEmailVerified;
  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.isEmailVerified,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    bool? isEmailVerified,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'isEmailVerified': isEmailVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      isEmailVerified: map['isEmailVerified'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, displayName: $displayName, isEmailVerified: $isEmailVerified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.email == email &&
        other.displayName == displayName &&
        other.isEmailVerified == isEmailVerified;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        isEmailVerified.hashCode;
  }
}
