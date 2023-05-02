class DataCreatePostResponse {
  String id = "";
  List<String> imagePost = [];
  String? caption = "";
  int likes = 0;
  List<String> cmt = [];
  String privacy = "";
  String userIdOfPost = "";
  String userLocation = "";
  String checkInLocation = "";
  String? updatedAt = "";
  DataCreatePostResponse(this.id, this.imagePost, this.caption, this.likes,this.cmt,
      this.privacy, this.userIdOfPost, this.userLocation, this.checkInLocation,this.updatedAt);
  DataCreatePostResponse.buildDefault();
  factory DataCreatePostResponse.fromJson(Map<String, dynamic> json) {
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
    return DataCreatePostResponse(
      json['_id'],
      photoPath,
      json['caption'],
      json['total_likes'],
      cmt,
      json['privacy'],
      json['user_id'],
      json['user_location'],
      json['checkin_location'],
      json['updatedAt'],
    );
  }
}
