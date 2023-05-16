class DeleteStoryRequest {
  String storyId;

  DeleteStoryRequest(this.storyId);

  Map<String, dynamic> toBodyRequest() => {
        'storyId': storyId,
      };
}
