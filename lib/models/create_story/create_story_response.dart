class CreateStoryResponse {
  bool status = false;

  CreateStoryResponse(this.status);
  CreateStoryResponse.buildDefault();
  factory CreateStoryResponse.fromJson(Map<String, dynamic> json) {
    return CreateStoryResponse(
      json['status'],
    );
  }
}
