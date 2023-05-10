import 'package:instagram_app/models/list_posts_home/user_infor_response.dart';

class DataPostsResponse {
  String id = "";
  List<String>? photoPath;
  String? caption = "";
  int totalLikes = 0;
  List<String>? listLike;
  bool liked = false;
  bool isAvatar = false;
  String privacy = "";
  UserInfoResponse? userInfoResponse;
  String userLocation = "";
  String checkInLocation = "";
  String? updatedAt = "";
  int? totalCmt;
  DataPostsResponse(
      this.id,
      this.photoPath,
      this.caption,
      this.totalLikes,
      this.listLike,
      this.liked,
      this.isAvatar,
      this.privacy,
      this.userInfoResponse,
      this.userLocation,
      this.checkInLocation,
      this.updatedAt,
      this.totalCmt);
  DataPostsResponse.buildDefault();
  factory DataPostsResponse.fromJson(Map<String, dynamic> json) {
    List<String>? photoPath = [];
    if (json['photo_path'] != null) {
      List<dynamic> arrData = json['photo_path'];
      for (int i = 0; i < arrData.length; i++) {
        photoPath.add(arrData[i]);
      }
    }
    List<String>? listLikes = [];
    if (json['list_likes'] != null) {
      List<dynamic> arrData = json['list_likes'];
      for (int i = 0; i < arrData.length; i++) {
        listLikes.add(arrData[i]);
      }
    }
    return DataPostsResponse(
      json['_id'],
      photoPath,
      json['caption'],
      json['total_likes'],
      listLikes,
      json['liked'],
      json['isAvatar'],
      json['privacy'],
      (json['user_id'] != null)
          ? UserInfoResponse.fromJson(json['user_id'])
          : null,
      json['user_location'],
      json['checkin_location'],
      json['uploadAt'],
      json['total_comment'],
    );
  }
}
