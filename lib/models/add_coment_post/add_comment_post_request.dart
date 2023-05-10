class AddCommentPostRequest {
  String mPostId;
  String mComment;

  AddCommentPostRequest(this.mPostId, this.mComment);

  Map<String, dynamic> toBodyRequest() => {
        'postId': mPostId,
        'comment': mComment,
      };
}
