class AddFriendResponse {
  bool status = false;

  AddFriendResponse(
    this.status,
  );
  AddFriendResponse.buildDefault();
  factory AddFriendResponse.fromJson(Map<String, dynamic> json) {
    return AddFriendResponse(json['status']);
  }
}
