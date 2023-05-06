class LikePostRequest {
  String mPostId;

  LikePostRequest(this.mPostId);

  Map<String, dynamic> toBodyRequest() => {
        'postId': mPostId,
      };
}
