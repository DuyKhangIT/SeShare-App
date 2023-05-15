import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/page/main/home_screen/create_story/create_story_view.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/upload_media/upload_media_response.dart';


class CreateStoryController extends GetxController {
  TextEditingController inputTextStoryController = TextEditingController();
  File? avatar;
  List<String> photoPath = [];
  String photo = "";
  String textStory = "";
  String filePath = "";
  double xPosition = 0.0;
  double yPosition = 0.0;
  double scaleValue = 2.0;
  bool addText = false;
  bool addColor = false;
  bool isScale = false;
  String colorValue = "";

  @override
  void onReady() {
    inputTextStoryController.text = "";
    textStory = "";
    avatar = null;
    addText = false;
    addColor = false;
    colorValue = "0xffffffff";
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



  /// upload image api
  Future<UploadMediaResponse> uploadMedia() async {
    UploadMediaResponse uploadMediaResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeSingleFile(
          Uri.parse("http://14.225.204.248:8080/api/photo/upload"),
          RequestType.post,
          filePath,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to upload file ${(error)}");
      rethrow;
    }
    if (body == null) return UploadMediaResponse.buildDefault();
    uploadMediaResponse = UploadMediaResponse.fromJson(body);
    if(uploadMediaResponse.status == true){
      photo = uploadMediaResponse.data!;
      if(photo!=null && photo.isNotEmpty){
        photoPath.add(photo);
        update();
      }
    }
    return uploadMediaResponse;
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
    filePath = filePaths;
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
    filePath = filePaths;
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
