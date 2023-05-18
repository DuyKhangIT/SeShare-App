class UserInfoMyStoryResponse {
  String id = "";
  String fullName = "";
  String avatar = "";

  UserInfoMyStoryResponse(this.id, this.fullName, this.avatar);

  UserInfoMyStoryResponse.buildDefault();

  factory UserInfoMyStoryResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoMyStoryResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
    );
  }
}
