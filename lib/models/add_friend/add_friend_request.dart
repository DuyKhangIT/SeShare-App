class AddFriendRequest {
  String userId;

  AddFriendRequest(this.userId);

  Map<String, dynamic> toBodyRequest() => {
    'userB': userId,
  };
}
