class UpdatePostResponse {
  bool status = false;

  UpdatePostResponse(this.status);
  UpdatePostResponse.buildDefault();
  factory UpdatePostResponse.fromJson(Map<String, dynamic> json) {
    return UpdatePostResponse(
      json['status'],
    );
  }
}
