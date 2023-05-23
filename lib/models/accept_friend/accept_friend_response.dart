class AcceptFriendResponse {
  bool status = false;

  AcceptFriendResponse(
    this.status,
  );
  AcceptFriendResponse.buildDefault();
  factory AcceptFriendResponse.fromJson(Map<String, dynamic> json) {
    return AcceptFriendResponse(json['status']);
  }
}
