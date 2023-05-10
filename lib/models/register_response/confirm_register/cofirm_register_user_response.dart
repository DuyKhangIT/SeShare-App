class ConfirmRegisterUserResponse {
  String phone = "";
  String? gender = "";
  String fullName = "";
  String? avatarPath = "";
  String? backgroundPath = "";
  String? bio = "";
  List<String>? friend;
  String id = "";
  String? updatedAt = "";
  String age = "";
  ConfirmRegisterUserResponse(
      this.phone,
      this.gender,
      this.fullName,
      this.avatarPath,
      this.backgroundPath,
      this.bio,
      this.friend,
      this.id,
      this.updatedAt,
      this.age);
  ConfirmRegisterUserResponse.buildDefault();
  factory ConfirmRegisterUserResponse.fromJson(Map<String, dynamic> json) {
    List<String> friendResponse = [];
    if (json['friends'] != null) {
      List<dynamic> arrData = json['friends'];
      for (var i = 0; i < arrData.length; i++) {
        String friend = arrData[i];
        friendResponse.add(friend);
      }
    }
    return ConfirmRegisterUserResponse(
      json['phone'],
      json['gender'],
      json['full_name'],
      json['avatar_path'],
      json['background_path'],
      json['bio'],
      friendResponse,
      json['_id'],
      json['updatedAt'],
      json['age'],
    );
  }
}
