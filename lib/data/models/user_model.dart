class UserModel {
  String uid;
  String email;
  String initials;
  String displayName;
  bool isEmailVerified;
  Function updateProfile;

  UserModel({
    this.uid,
    this.email,
    this.initials,
    this.displayName,
    this.updateProfile,
    this.isEmailVerified,
  });
}
