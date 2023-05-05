class GetAllPhotoUserResponse {
  bool status = false;
  List<String>? listPhotosUser;

  GetAllPhotoUserResponse(
    this.status,
    this.listPhotosUser,
  );
  GetAllPhotoUserResponse.buildDefault();
  factory GetAllPhotoUserResponse.fromJson(Map<String, dynamic> json) {
    List<String>? listPhotos = [];
    if (json['listPhotos'] != null) {
      List<dynamic> arrData = json['listPhotos'];
      for (int i = 0; i < arrData.length; i++) {
        listPhotos.add(arrData[i]);
      }
    }
    return GetAllPhotoUserResponse(
      json['status'],
      listPhotos,
    );
  }
}
