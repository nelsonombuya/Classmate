class UserModel {
  String uid;
  String email;
  String initials;
  String displayName;
  bool isEmailVerified;

  UserModel({
    this.uid,
    this.email,
    this.initials,
    this.displayName,
    this.isEmailVerified,
  });
}
