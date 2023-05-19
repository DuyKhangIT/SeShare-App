class ListAnotherPostRequest {
  String anOtherUserId;

  ListAnotherPostRequest(this.anOtherUserId);

  Map<String, dynamic> toBodyRequest() => {
        'anotherId': anOtherUserId,
      };
}
