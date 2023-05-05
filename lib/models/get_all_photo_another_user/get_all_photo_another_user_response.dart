class GetAllPhotoAnOtherUserResponse {
  bool status = false;
  List<String>? listPhotosUser;

  GetAllPhotoAnOtherUserResponse(
    this.status,
    this.listPhotosUser,
  );
  GetAllPhotoAnOtherUserResponse.buildDefault();
  factory GetAllPhotoAnOtherUserResponse.fromJson(Map<String, dynamic> json) {
    List<String>? listPhotos = [];
    if (json['listPhotos'] != null) {
      List<dynamic> arrData = json['listPhotos'];
      for (int i = 0; i < arrData.length; i++) {
        listPhotos.add(arrData[i]);
      }
    }
    return GetAllPhotoAnOtherUserResponse(
      json['status'],
      listPhotos,
    );
  }
}
