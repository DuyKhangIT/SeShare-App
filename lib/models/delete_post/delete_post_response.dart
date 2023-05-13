class DeletePostResponse {
  bool status = false;

  DeletePostResponse(
    this.status,
  );
  DeletePostResponse.buildDefault();
  factory DeletePostResponse.fromJson(Map<String, dynamic> json) {
    return DeletePostResponse(json['status']);
  }
}
