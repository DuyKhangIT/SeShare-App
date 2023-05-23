class DenyOrUnfriendResponse {
  bool status = false;

  DenyOrUnfriendResponse(
    this.status,
  );
  DenyOrUnfriendResponse.buildDefault();
  factory DenyOrUnfriendResponse.fromJson(Map<String, dynamic> json) {
    return DenyOrUnfriendResponse(json['status']);
  }
}
