class UserInfoMyPostResponse {
  String id = "";
  String fullName = "";
  String avatar = "";

  UserInfoMyPostResponse(this.id, this.fullName, this.avatar);

  UserInfoMyPostResponse.buildDefault();

  factory UserInfoMyPostResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoMyPostResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
    );
  }
}
