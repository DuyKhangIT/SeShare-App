class UserProfileResponse {
  String id = "";
  String phone = "";
  String password = "";
  String? gender = "";
  String fullName = "";
  String? avatarPath = "";
  String? bio = "";
  List<String>? photo;
  List<String>? friend;
  String? updatedAt = "";
  UserProfileResponse(this.id, this.phone, this.password, this.gender,this.fullName,
      this.avatarPath,this.bio,this.photo,this.friend,this.updatedAt);
  UserProfileResponse.buildDefault();
  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    List<String> photoResponse = [];
    if (json['photos'] != null) {
      List<dynamic> arrData = json['photos'];
      for (var i = 0; i < arrData.length; i++) {
        String photoUrl = arrData[i];
        photoResponse.add(photoUrl);
      }
    }
    List<String> friendResponse = [];
    if (json['friends'] != null) {
      List<dynamic> arrData = json['friends'];
      for (var i = 0; i < arrData.length; i++) {
        String friend = arrData[i];
        friendResponse
            .add(friend);
      }
    }
    return UserProfileResponse(
      json['_id'],
      json['phone'],
      json['password'],
      json['gender'],
      json['full_name'],
      json['avatar_path'],
      json['bio'],
      photoResponse,
      friendResponse,
      json['updatedAt'],
    );
  }
}
