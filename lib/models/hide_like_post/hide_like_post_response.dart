class HideLikePostResponse {
  bool status = false;

  HideLikePostResponse(
    this.status,
  );
  HideLikePostResponse.buildDefault();
  factory HideLikePostResponse.fromJson(Map<String, dynamic> json) {
    return HideLikePostResponse(
      json['status'],
    );
  }
}
