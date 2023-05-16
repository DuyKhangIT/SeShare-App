class UserInfoStoryResponse {
  String id = "";
  String fullName = "";
  String avatar = "";

  UserInfoStoryResponse(this.id, this.fullName, this.avatar);

  UserInfoStoryResponse.buildDefault();

  factory UserInfoStoryResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoStoryResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
    );
  }
}
