class ListFavoriteStoriesAnotherUserRequest {
  String anOtherUserId;

  ListFavoriteStoriesAnotherUserRequest(this.anOtherUserId);

  Map<String, dynamic> toBodyRequest() => {
        'anotherId': anOtherUserId,
      };
}
