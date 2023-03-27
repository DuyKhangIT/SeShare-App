class UserResponse {
  String mId = "";
  String mPhone = "";
  String mPassword = "";
  String? mAge = "";
  String? mGender = "";
  String? mAvatarPath = "";
  List<String>? mPhoto;
  List<String>? mFriends;
  String? mUpdatedAt = "";
  UserResponse(this.mId, this.mPhone, this.mPassword, this.mGender, this.mAge,
      this.mAvatarPath,this.mPhoto,this.mFriends,this.mUpdatedAt);
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
        friendResponse
            .add(friend);
      }
    }
    return UserResponse(
      json['_id'],
      json['phone'],
      json['password'],
      json['age'],
      json['gender'],
      json['avatar_path'],
      photoResponse,
      friendResponse,
      json['updatedAt'],
    );
  }
}
