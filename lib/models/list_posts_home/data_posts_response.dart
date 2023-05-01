import 'package:instagram_app/models/list_posts_home/user_infor_response.dart';

class DataPostsResponse {
  String id = "";
  List<String>? photoPath;
  String? caption = "";
  int likes = 0;
  List<String>? cmt;
  String privacy = "";
  UserInfoResponse? userInfoResponse;
  String userLocation = "";
  String checkInLocation = "";
  String? updatedAt = "";
  DataPostsResponse(this.id, this.photoPath, this.caption, this.likes,this.cmt,
      this.privacy,this.userInfoResponse, this.userLocation, this.checkInLocation,this.updatedAt);
  DataPostsResponse.buildDefault();
  factory DataPostsResponse.fromJson(Map<String, dynamic> json) {
    List<String>? photoPath = [];
    if (json['photo_path'] != null) {
      List<dynamic> arrData = json['photo_path'];
      for (int i = 0; i < arrData.length; i++) {
        photoPath
            .add(arrData[i]);
      }
    }
    List<String>? cmt = [];
    if (json['comment'] != null) {
      List<dynamic> arrData = json['comment'];
      for (int i = 0; i < arrData.length; i++) {
        photoPath
            .add(arrData[i]);
      }
    }
    return DataPostsResponse(
      json['_id'],
      photoPath,
      json['caption'],
      json['likes'],
      cmt,
      json['privacy'],
      (json['user_id'] != null) ? UserInfoResponse.fromJson(json['user_id']) : null,
      json['user_location'],
      json['checkin_location'],
      json['updatedAt'],
    );
  }
}
