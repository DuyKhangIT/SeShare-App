class AcceptFriendRequest {
  String userId;

  AcceptFriendRequest(this.userId);

  Map<String, dynamic> toBodyRequest() => {
    'userB': userId,
  };
}
