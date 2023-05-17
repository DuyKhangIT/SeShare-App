class FavoriteStoryResponse {
  bool status = false;

  FavoriteStoryResponse(
    this.status,
  );
  FavoriteStoryResponse.buildDefault();
  factory FavoriteStoryResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteStoryResponse(json['status']);
  }
}
