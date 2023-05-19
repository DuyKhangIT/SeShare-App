class UserInfoAnotherPostResponse {
  String id = "";
  String fullName = "";
  String avatar = "";

  UserInfoAnotherPostResponse(this.id, this.fullName, this.avatar);

  UserInfoAnotherPostResponse.buildDefault();

  factory UserInfoAnotherPostResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoAnotherPostResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
    );
  }
}
