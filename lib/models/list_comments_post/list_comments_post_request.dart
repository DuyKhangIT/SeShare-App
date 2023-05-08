class ListCommentsPostRequest {
  String mPostId;

  ListCommentsPostRequest(this.mPostId);

  Map<String, dynamic> toBodyRequest() => {
        'postId': mPostId,
      };
}
