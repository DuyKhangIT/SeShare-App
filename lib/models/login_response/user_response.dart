class UserResponse {
  String? mId = "";
  String? mPhone = "";
  String? mPassword = "";
  String? mAge = "";
  String? mGender = "";
  String? mAvatarPath = "";
  List<String>? mPhoto;
  List<String>? mFriends;
  List<String>? mStatus;
  int? mV = 0;
  String? mUpdatedAt = "";
  UserResponse(this.mId, this.mPhone, this.mPassword, this.mGender, this.mAge,
      this.mAvatarPath,this.mPhoto,this.mFriends,this.mStatus,this.mV,this.mUpdatedAt);
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
    List<String> statusResponse = [];
    if (json['status'] != null) {
      List<dynamic> arrData = json['status'];
      for (var i = 0; i < arrData.length; i++) {
        String status = arrData[i];
        statusResponse
            .add(status);
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
      statusResponse,
      json['__v'],
      json['updatedAt'],
    );
  }
}
