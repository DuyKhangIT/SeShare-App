class CreateChatResponse {
  String roomId = "";

  CreateChatResponse(this.roomId);
  CreateChatResponse.buildDefault();
  factory CreateChatResponse.fromJson(Map<String, dynamic> json) {
    return CreateChatResponse(
      json['roomId'],
    );
  }
}
