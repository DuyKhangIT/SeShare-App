class HideCommentPostResponse {
  bool status = false;

  HideCommentPostResponse(
    this.status,
  );
  HideCommentPostResponse.buildDefault();
  factory HideCommentPostResponse.fromJson(Map<String, dynamic> json) {
    return HideCommentPostResponse(
      json['status'],
    );
  }
}
