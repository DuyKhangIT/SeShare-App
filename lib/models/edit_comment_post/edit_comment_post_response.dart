class EditCommentPostResponse {
  bool status = false;

  EditCommentPostResponse(this.status);

  EditCommentPostResponse.buildDefault();

  factory EditCommentPostResponse.fromJson(Map<String, dynamic> json) {
    return EditCommentPostResponse(
      json['status'],
    );
  }
}
