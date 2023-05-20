class DataSearchUserResponse {
  String id = "";
  String phone = "";
  String fullName = "";
  String avatar = "";
  String bio = "";

  DataSearchUserResponse(
      this.id, this.phone, this.fullName, this.avatar, this.bio);
  DataSearchUserResponse.buildDefault();
  factory DataSearchUserResponse.fromJson(Map<String, dynamic> json) {
    return DataSearchUserResponse(
      json['_id'],
      json['phone'],
      json['full_name'],
      json['avatar_path'],
      json['bio'],
    );
  }
}
