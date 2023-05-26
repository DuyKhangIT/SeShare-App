class HideLikePostRequest {
  String mPostId;

  HideLikePostRequest(this.mPostId);

  Map<String, dynamic> toBodyRequest() => {
    'postId': mPostId,
  };
}
