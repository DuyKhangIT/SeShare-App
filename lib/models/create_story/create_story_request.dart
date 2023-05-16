class CreateStoryRequest {
  String mPhotoPath;
  double mXPositionText;
  double mYPositionText;
  double mScaleText;
  String mColorText;
  String mText;
  String mPrivacy;

  CreateStoryRequest(this.mPhotoPath, this.mXPositionText, this.mYPositionText,
      this.mScaleText, this.mColorText, this.mText, this.mPrivacy);

  Map<String, dynamic> toBodyRequest() => {
        'photoPath': mPhotoPath,
        'xText': mXPositionText,
        'yText': mYPositionText,
        'scaleText': mScaleText,
        'colorText': mColorText,
        'text': mText,
        'privacy': mPrivacy,
      };
}
