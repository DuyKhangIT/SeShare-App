import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class CreateStoryController extends GetxController {
  File? avatar;
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];
  RequestType? requestType;
  @override
  void onReady() {
    loadAlbums(requestType!).then((value) => {
      albumList = value,
      selectedAlbum = value[0],
      update,
      loadAssets(selectedAlbum!).then((value) => {
        assetList = value,
        update
      })
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  /// load album
  Future loadAlbums(RequestType requestType) async{
    var permission = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> albumList = [];

    if(permission.isAuth==true){
        albumList = await PhotoManager.getAssetPathList(
          type: requestType
        );
    }else{
      PhotoManager.openSetting();
    }
    return albumList;
  }
  Future loadAssets(AssetPathEntity selectedAlbums)async{
    List<AssetEntity> assetList = await selectedAlbums.getAssetListRange(start: 0, end: selectedAlbums.assetCount);
    return assetList;
  }

  /// instantiate our image picker object
  final imagePicker = ImagePicker();

  /// function to get the image from the camera
  Future getImageFromCamera() async {
    final pickedImageFromCam =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImageFromCam == null) {
      return;
    }
    File? picture = File(pickedImageFromCam.path);
    picture = await cropperImage(imgFile: picture);
    if (picture == null) {
      return;
    }
    avatar = picture;
    Navigator.pop(Get.context!);

    String filePaths;
    filePaths = picture.path;
    update();
  }

  /// function to get the image from the gallery
  Future getImageFromGallery() async {
    final pickedImageFromGa =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImageFromGa == null) {
      return;
    }
    File? imgFrame = File(pickedImageFromGa.path);
    imgFrame = await cropperImage(imgFile: imgFrame);
    if (imgFrame == null) {
      return;
    }
    avatar = imgFrame;
    Navigator.pop(Get.context!);

    String filePaths;
    filePaths = imgFrame.path;
    update();
  }

  /// function to adjustment the image frame
  Future<File?> cropperImage({required File imgFile}) async {
    CroppedFile? cropperImage =
        await ImageCropper().cropImage(sourcePath: imgFile.path);
    if (cropperImage == null) return null;
    return File(cropperImage.path);
  }
}
