class UserResponse {
  String? mId = "";
  String? mPhone = "";
  String? mPassword = "";
  String? mAge = "";
  String? mGender = "";
  String? mAvatarPath = "";
  List<String>? mPhoto = null;
  List<String>? mFriends = null;
  List<String>? mStatus = null;
  int? mV = 0;
  String? mUpdatedAt = "";
  UserResponse(this.mId, this.mPhone, this.mPassword, this.mGender, this.mAge,
      this.mAvatarPath,this.mPhoto,this.mFriends,this.mStatus,this.mV,this.mUpdatedAt);
  UserResponse.buildDefault();
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    List<String> photoResponse = [];
    if (json['photos'] != null) {
      List<String> arrData = json['photos'];
      for (var i = 0; i < arrData.length; i++) {
        photoResponse
            .add(json[arrData[i]]);
      }
    }
    List<String> friendResponse = [];
    if (json['friends'] != null) {
      List<String> arrData = json['friends'];
      for (var i = 0; i < arrData.length; i++) {
        friendResponse
            .add(json[arrData[i]]);
      }
    }
    List<String> statusResponse = [];
    if (json['status'] != null) {
      List<String> arrData = json['status'];
      for (var i = 0; i < arrData.length; i++) {
        statusResponse
            .add(json[arrData[i]]);
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
