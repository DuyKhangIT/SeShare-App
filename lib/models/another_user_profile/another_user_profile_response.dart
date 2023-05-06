class AnOtherUserProfileResponse {
  String id = "";
  String phone = "";
  String? gender = "";
  String fullName = "";
  String? avatarPath = "";
  String? bio = "";
  List<String>? friend;
  String? updatedAt = "";
  String? backgroundPath = "";
  String age = "";
  AnOtherUserProfileResponse(this.id, this.phone, this.gender,
      this.fullName, this.avatarPath, this.bio, this.friend, this.updatedAt,this.backgroundPath,this.age);
  AnOtherUserProfileResponse.buildDefault();
  factory AnOtherUserProfileResponse.fromJson(Map<String, dynamic> json) {
    List<String> friendResponse = [];
    if (json['friends'] != null) {
      List<dynamic> arrData = json['friends'];
      for (var i = 0; i < arrData.length; i++) {
        String friend = arrData[i];
        friendResponse.add(friend);
      }
    }
    return AnOtherUserProfileResponse(
      json['_id'],
      json['phone'],
      json['gender'],
      json['full_name'],
      json['avatar_path'],
      json['bio'],
      friendResponse,
      json['updatedAt'],
      json['background_path'],
      json['age'],
    );
  }
}
