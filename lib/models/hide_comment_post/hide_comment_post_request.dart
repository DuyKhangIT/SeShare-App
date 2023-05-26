class HideCommentPostRequest {
  String mPostId;

  HideCommentPostRequest(this.mPostId);

  Map<String, dynamic> toBodyRequest() => {
    'postId': mPostId,
  };
}
