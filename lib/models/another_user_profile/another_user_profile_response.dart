class AnOtherUserProfileResponse {
  String id = "";
  String phone = "";
  String? gender = "";
  String fullName = "";
  String place = "";
  String? avatarPath = "";
  String? bio = "";
  List<String>? friend;
  String? createdAt = "";
  String? backgroundPath = "";
  String age = "";
  int totalFriend = 0;
  int friendStatus = 0;
  AnOtherUserProfileResponse(this.id, this.phone, this.gender,
      this.fullName,this.place, this.avatarPath, this.bio, this.friend, this.createdAt,this.backgroundPath,this.age,this.totalFriend,this.friendStatus);
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
      json['place'],
      json['avatar_path'],
      json['bio'],
      friendResponse,
      json['createdAt'],
      json['background_path'],
      json['age'],
      json['total_friends'],
      json['friendStatus'],
    );
  }
}
