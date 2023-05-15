class DeleteCommentPostResponse {
  bool status = false;

  DeleteCommentPostResponse(this.status);

  DeleteCommentPostResponse.buildDefault();

  factory DeleteCommentPostResponse.fromJson(Map<String, dynamic> json) {
    return DeleteCommentPostResponse(
      json['status'],
    );
  }
}
