class CreatePostRequest {
  String mUserId;
  String mCaption;
  bool mIsAvatar;
  String mUserLocation;
  String mCheckInLocation;
  String mPrivacy;
  List<String>? photos;

  CreatePostRequest(this.mUserId, this.mCaption, this.mIsAvatar,
      this.mUserLocation, this.mCheckInLocation, this.mPrivacy, this.photos);

  Map<String, dynamic> toBodyRequest() => {
        'userId': mUserId,
        'caption': mCaption,
        'isAvatar': mIsAvatar,
        'userLocation': mUserLocation,
        'checkinLocation': mCheckInLocation,
        'privacy': mPrivacy,
        'photos': photos,
      };
}
