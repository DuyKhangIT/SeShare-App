class UserResponse {
  String id = "";
  String phone = "";
  String? gender = "";
  String fullName = "";
  String? avatarPath = "";
  List<String>? photo;
  List<String>? friend;
  String? updatedAt = "";
  String? backgroundPath = "";
  String age = "";
  UserResponse(this.id, this.phone, this.gender, this.fullName, this.avatarPath,
      this.photo, this.friend, this.updatedAt, this.backgroundPath, this.age);
  UserResponse.buildDefault();
  factory UserResponse.fromJson(Map<String, dynamic> json) {
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
        friendResponse.add(friend);
      }
    }
    return UserResponse(
      json['_id'],
      json['phone'],
      json['gender'],
      json['full_name'],
      json['avatar_path'],
      photoResponse,
      friendResponse,
      json['updatedAt'],
      json['background_path'],
      json['age'],
    );
  }
}
