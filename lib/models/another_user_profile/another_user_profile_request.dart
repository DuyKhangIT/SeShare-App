class AnotherUserProfileRequest {
  String anOtherUserId;

  AnotherUserProfileRequest(this.anOtherUserId);

  Map<String, dynamic> toBodyRequest() => {
        'anotherId': anOtherUserId,
      };
}
