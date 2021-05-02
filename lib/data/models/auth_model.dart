import 'dart:convert';

class AuthModel {
  String uid;
  String? email;
  String? displayName;
  bool isEmailVerified;

  AuthModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.isEmailVerified,
  });

  AuthModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    bool? isEmailVerified,
  }) {
    return AuthModel(
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

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      isEmailVerified: map['isEmailVerified'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthModel(uid: $uid, email: $email, displayName: $displayName, isEmailVerified: $isEmailVerified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthModel &&
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
