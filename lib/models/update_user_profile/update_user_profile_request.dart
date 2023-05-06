class UpdateUserProfileRequest {
  String? gender;
  String fullName;
  String? avatarPath;
  String? bio;
  String? backgroundPath;
  String? age;

  UpdateUserProfileRequest(this.gender, this.fullName, this.avatarPath,
      this.bio, this.backgroundPath, this.age);

  Map<String, dynamic> toBodyRequest() => {
        'gender': gender,
        'full_name': fullName,
        'avatar_path': avatarPath,
        'bio': bio,
        'background_path': backgroundPath,
        'age': age,
      };
}
