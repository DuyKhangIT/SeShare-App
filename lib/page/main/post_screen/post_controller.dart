import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/page/main/post_screen/changed_address/changed_address_view.dart';

import '../../../util/global.dart';

class PostController extends GetxController {
  TextEditingController inputStatusController = TextEditingController();
  String statusPost = "";
  File? avatar;
  Color? color;
  String checkInPost = "";

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> captureData() async {
    var result = await Get.to(ChangedAddressView());
    checkInPost = result;
    update();
  }

  @override
  void onClose() {
    super.onClose();
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
    Global.registerNewAvatar = filePaths;
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
    Global.registerNewAvatar = filePaths;
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
