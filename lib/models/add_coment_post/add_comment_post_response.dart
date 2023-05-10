class AddCommentPostResponse {
  bool status = false;

  AddCommentPostResponse(this.status);

  AddCommentPostResponse.buildDefault();

  factory AddCommentPostResponse.fromJson(Map<String, dynamic> json) {
    return AddCommentPostResponse(
      json['status'],
    );
  }
}
