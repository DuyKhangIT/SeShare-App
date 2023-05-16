class CreateStoryRequest {
  String mPhotoPath;
  String mPrivacy;

  CreateStoryRequest(this.mPhotoPath, this.mPrivacy);

  Map<String, dynamic> toBodyRequest() => {
        'photoPath': mPhotoPath,
        'privacy': mPrivacy,
      };
}
