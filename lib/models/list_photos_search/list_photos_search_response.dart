class ListPhotosSearchResponse {
  bool status = false;
  List<String> data = [];

  ListPhotosSearchResponse(this.status, this.data);

  ListPhotosSearchResponse.buildDefault();

  factory ListPhotosSearchResponse.fromJson(Map<String, dynamic> json) {
    List<String> listDataPhotos = [];
    if (json['data'] != null) {
      List<dynamic> arrData = json['data'];
      for (int i = 0; i < arrData.length; i++) {
        listDataPhotos.add(arrData[i]);
      }
    }
    return ListPhotosSearchResponse(
      json['status'],
      listDataPhotos,
    );
  }
}
