class LikePostResponse {
  bool status = false;

  LikePostResponse(
    this.status,
  );
  LikePostResponse.buildDefault();
  factory LikePostResponse.fromJson(Map<String, dynamic> json) {
    return LikePostResponse(
      json['status'],
    );
  }
}
