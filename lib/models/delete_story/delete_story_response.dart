class DeleteStoryResponse {
  bool status = false;

  DeleteStoryResponse(
    this.status,
  );
  DeleteStoryResponse.buildDefault();
  factory DeleteStoryResponse.fromJson(Map<String, dynamic> json) {
    return DeleteStoryResponse(json['status']);
  }
}
