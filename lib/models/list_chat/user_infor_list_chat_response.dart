class UserInfoListChatResponse {
  String id = "";
  String fullName = "";
  String avatar = "";

  UserInfoListChatResponse(this.id, this.fullName, this.avatar);

  UserInfoListChatResponse.buildDefault();

  factory UserInfoListChatResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoListChatResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
    );
  }
}
