class UserModel {
  String uid;
  String email;
  String displayName;
  bool isEmailVerified;
  Function updateProfile;

  UserModel({
    this.uid,
    this.email,
    this.displayName,
    this.updateProfile,
    this.isEmailVerified,
  });
}
