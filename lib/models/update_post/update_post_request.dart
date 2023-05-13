class UpdatePostRequest {
  String postId;
  String caption;
  String checkinLocation;
  String privacy;

  UpdatePostRequest(
      this.postId, this.caption, this.checkinLocation, this.privacy);

  Map<String, dynamic> toBodyRequest() => {
        'postId': postId,
        'caption': caption,
        'checkin_location': checkinLocation,
        'privacy': privacy,
      };
}
