class DataMyPostResponse {
  String id = "";
  List<String>? photoPath;
  String? caption = "";
  int totalLikes = 0;
  List<String>? listLike;
  bool liked = false;
  int? totalCmt;
  bool isAvatar = false;
  String privacy = "";
  String userId = "";
  String userLocation = "";
  String checkInLocation = "";
  String? updatedAt = "";

  DataMyPostResponse(
      this.id,
      this.photoPath,
      this.caption,
      this.totalLikes,
      this.listLike,
      this.liked,
      this.totalCmt,
      this.isAvatar,
      this.privacy,
      this.userId,
      this.userLocation,
      this.checkInLocation,
      this.updatedAt);
  DataMyPostResponse.buildDefault();
  factory DataMyPostResponse.fromJson(Map<String, dynamic> json) {
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
    return DataMyPostResponse(
        json['_id'],
        photoPath,
        json['caption'],
        json['total_likes'],
        listLikes,
        json['liked'],
        json['total_comment'],
        json['isAvatar'],
        json['privacy'],
        json['user_id'],
        json['user_location'],
        json['checkin_location'],
        json['uploadAt']);
  }
}
