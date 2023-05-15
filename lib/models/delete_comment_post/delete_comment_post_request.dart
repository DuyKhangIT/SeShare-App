class DeleteCommentPostRequest {
  String mPostId;
  String mCommentId;

  DeleteCommentPostRequest(this.mPostId, this.mCommentId);

  Map<String, dynamic> toBodyRequest() => {
        'postId': mPostId,
        'commentId': mCommentId,
      };
}
