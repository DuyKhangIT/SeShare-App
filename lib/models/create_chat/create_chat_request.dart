class CreateChatRequest {
  String otherUserId;

  CreateChatRequest(this.otherUserId);

  Map<String, dynamic> toBodyRequest() => {
        'userB': otherUserId,
      };
}
