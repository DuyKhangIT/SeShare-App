class UpdateUserProfileRequest {
  String phone;
  String password;
  String? gender;
  String fullName;
  String? avatarPath;
  String? bio;

  UpdateUserProfileRequest(this.phone, this.password, this.gender,
      this.fullName, this.avatarPath, this.bio);

  Map<String, dynamic> toBodyRequest() => {
        'phone': phone,
        'password': password,
        'gender': gender,
        'full_name': fullName,
        'avatar_path': avatarPath,
        'bio': bio,
      };
}
