class DenyOrUnfriendRequest {
  String userId;

  DenyOrUnfriendRequest(this.userId);

  Map<String, dynamic> toBodyRequest() => {
    'userB': userId,
  };
}
