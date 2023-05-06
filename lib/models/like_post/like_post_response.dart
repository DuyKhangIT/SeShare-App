import 'like_post_data_response.dart';

class LikePostResponse {
  bool status = false;
  LikePostDataResponse? likePostDataResponse;

  LikePostResponse(
      this.status,
      this.likePostDataResponse,
      );
  LikePostResponse.buildDefault();
  factory LikePostResponse.fromJson(Map<String, dynamic> json) {
    return LikePostResponse(
      json['status'],
      (json['data'] != null) ? LikePostDataResponse.fromJson(json['data']) : null,
    );
  }
}
