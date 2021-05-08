import 'dart:convert';

class UserModel {
  final String uid;
  final String? email;
  final String? displayName;
  const UserModel({
    required this.uid,
    this.email,
    this.displayName,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(uid: $uid, email: $email, displayName: $displayName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.email == email &&
        other.displayName == displayName;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ displayName.hashCode;

  static const empty = UserModel(
    uid: "-",
    email: "-",
    displayName: "-",
  );
}
