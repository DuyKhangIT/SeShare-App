class LikePostDataResponse {
  String id = "";
  int totalLike = 0;
  List<String> listLike = [];
  LikePostDataResponse(this.id, this.totalLike, this.listLike);
  LikePostDataResponse.buildDefault();
  factory LikePostDataResponse.fromJson(Map<String, dynamic> json) {
    List<String>? listLikeRes = [];
    if (json['list_likes'] != null) {
      List<dynamic> arrData = json['list_likes'];
      for (int i = 0; i < arrData.length; i++) {
        listLikeRes.add(arrData[i]);
      }
    }
    return LikePostDataResponse(
      json['_id'],
      json['total_likes'],
      listLikeRes,
    );
  }
}
