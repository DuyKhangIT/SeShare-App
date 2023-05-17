class FavoriteStoryRequest {
  String storyId;

  FavoriteStoryRequest(this.storyId);

  Map<String, dynamic> toBodyRequest() => {
    'storyId': storyId,
  };
}
