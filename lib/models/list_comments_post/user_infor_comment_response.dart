class UserInfoCommentResponse {
  String id = "";
  String fullName = "";
  String avatar = "";

  UserInfoCommentResponse(this.id, this.fullName, this.avatar);

  UserInfoCommentResponse.buildDefault();

  factory UserInfoCommentResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoCommentResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
    );
  }
}
