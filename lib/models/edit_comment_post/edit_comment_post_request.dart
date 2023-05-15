class EditCommentPostRequest {
  String mPostId;
  String mCommentId;
  String mNewComment;

  EditCommentPostRequest(this.mPostId, this.mCommentId,this.mNewComment);

  Map<String, dynamic> toBodyRequest() => {
        'postId': mPostId,
        'commentId': mCommentId,
        'newComment': mNewComment,
      };
}
