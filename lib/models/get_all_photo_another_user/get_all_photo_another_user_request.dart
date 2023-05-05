class GetAllPhotoAnotherUserRequest {
  String anOtherUserId;

  GetAllPhotoAnotherUserRequest(this.anOtherUserId);

  Map<String, dynamic> toBodyRequest() => {
        'anotherId': anOtherUserId,
      };
}
