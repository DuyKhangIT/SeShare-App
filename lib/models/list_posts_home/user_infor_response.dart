class UserInfoResponse {
  String id = "";
  String fullName = "";
  String avatar = "";

  UserInfoResponse(this.id, this.fullName, this.avatar);

  UserInfoResponse.buildDefault();

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
    );
  }
}
