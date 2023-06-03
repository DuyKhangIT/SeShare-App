class WhoUserObjectResponse {
  String id = "";
  String fullName = "";
  String avatar = "";

  WhoUserObjectResponse(this.id, this.fullName, this.avatar);

  WhoUserObjectResponse.buildDefault();

  factory WhoUserObjectResponse.fromJson(Map<String, dynamic> json) {
    return WhoUserObjectResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
    );
  }
}
