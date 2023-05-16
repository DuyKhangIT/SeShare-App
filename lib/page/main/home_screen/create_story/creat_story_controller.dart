import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/models/create_story/create_story_request.dart';
import 'package:instagram_app/models/create_story/create_story_response.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/upload_media/upload_media_response.dart';
import '../../../navigation_bar/navigation_bar_view.dart';

class CreateStoryController extends GetxController {
  TextEditingController inputTextStoryController = TextEditingController();
  File? avatar;
  String photo = "";
  String textStory = "";
  String filePath = "";
  double xPosition = 0.0;
  double yPosition = 0.0;
  double scaleValue = 2.0;
  bool addText = false;
  bool addColor = false;
  bool isScale = false;
  bool isLoading = false;
  String colorValue = "";
  String privacy = "";

  @override
  void onReady() {
    inputTextStoryController.text = "";
    textStory = "";
    avatar = null;
    addText = false;
    addColor = false;
    colorValue = "0xffffffff";
    privacy = "public";
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void handleCreateStory() {
    if (avatar != null) {
      uploadMedia();
    } else {
      debugPrint("Bạn chưa thêm hình");
    }
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
    if (uploadMediaResponse.status == true) {
      photo = uploadMediaResponse.data!;
      if (photo.isNotEmpty) {
        CreateStoryRequest createStoryRequest = CreateStoryRequest(photo,
            xPosition, yPosition, scaleValue, colorValue, textStory, privacy);
        createStory(createStoryRequest);
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

  /// create story
  Future<CreateStoryResponse> createStory(
      CreateStoryRequest createStoryRequest) async {
    isLoading = true;
    if (isLoading) {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
    } else {
      Get.back(); // Đóng hộp thoại loading nếu isLoading = false
    }
    CreateStoryResponse createStoryResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/story/create-story"),
          RequestType.post,
          headers: null,
          body:
              const JsonEncoder().convert(createStoryRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to create story $error");
      rethrow;
    }
    if (body == null) return CreateStoryResponse.buildDefault();
    //get data from api here
    createStoryResponse = CreateStoryResponse.fromJson(body);
    if (createStoryResponse.status == true) {
      isLoading = false;
      if (isLoading) {
        Get.dialog(const Center(child: CircularProgressIndicator()),
            barrierDismissible: false);
      } else {
        Get.back(); // Đóng hộp thoại loading nếu isLoading = false
      }
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Thành công!',
          message: "Tạo tin thành công",
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      Get.offAll(() => NavigationBarView(currentIndex: 0));
    }
    return createStoryResponse;
  }
}
