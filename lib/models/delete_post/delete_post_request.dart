class DeletePostRequest {
  String postId;

  DeletePostRequest(this.postId);

  Map<String, dynamic> toBodyRequest() => {
        'postId': postId,
      };
}
