import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/models/create_post/create_post_request.dart';
import 'package:instagram_app/models/upload_media/upload_media_response.dart';
import 'package:instagram_app/page/main/post_screen/changed_address/changed_address_view.dart';
import 'package:instagram_app/page/navigation_bar/navigation_bar_view.dart';
import 'package:instagram_app/util/global.dart';

import '../../../api_http/handle_api.dart';
import '../../../models/create_post/create_posts_response.dart';

class PostController extends GetxController {
  TextEditingController inputStatusController = TextEditingController();
  String captionPost = "";
  File? avatar;
  String checkInPost = "";
  String filePath = "";
  RxBool isPublic = false.obs;
  RxBool isPrivate = false.obs;
  RxBool isFriend = false.obs;
  String privacy = "";
  List<String> photoPath = [];
  String photo = "";
  bool isLoading = false;
  @override
  void onReady() {
    checkInPost = "";
    inputStatusController.text = "";
    privacy = "public";
    isPublic.value = true;
    avatar = null;
    update();
    super.onReady();
  }

  Future<void> captureData() async {
    var result = await Get.to(() => const ChangedAddressView());
    if (result != null) {
      checkInPost = result;
      update();
    }
  }

  @override
  void onClose() {
    inputStatusController.clear();
    checkInPost = "";
    avatar = null;
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
    Get.back();

    String filePaths;
    filePaths = picture.path;
    filePath = filePaths;
    update();
    if (avatar != null) {
      uploadMedia();
    }
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
    Get.back();

    String filePaths;
    filePaths = imgFrame.path;
    filePath = filePaths;
    update();
    if (avatar != null) {
      uploadMedia();
    }
  }

  /// function to adjustment the image frame
  Future<File?> cropperImage({required File imgFile}) async {
    CroppedFile? cropperImage =
        await ImageCropper().cropImage(sourcePath: imgFile.path);
    if (cropperImage == null) return null;
    return File(cropperImage.path);
  }

  void posts() {
    CreatePostRequest createPostRequest = CreatePostRequest(captionPost, false,
        Global.currentLocation, checkInPost, privacy, photoPath);
    createPost(createPostRequest);
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
      if (photo != null && photo.isNotEmpty) {
        photoPath.add(photo);
        update();
      }
    }
    return uploadMediaResponse;
  }

  /// create post
  Future<CreatePostResponse> createPost(
      CreatePostRequest createPostRequest) async {
    isLoading = true;
    if (isLoading) {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
    } else {
      Get.back(); // Đóng hộp thoại loading nếu isLoading = false
    }
    CreatePostResponse createPostResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/photo/upload-post"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(createPostRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to create post $error");
      rethrow;
    }
    if (body == null) return CreatePostResponse.buildDefault();
    //get data from api here
    createPostResponse = CreatePostResponse.fromJson(body);
    if (createPostResponse.status == true) {
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
          message: "Tạo bài viết thành công",
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      Get.offAll(() => NavigationBarView(
            currentIndex: 0,
          ));
    }
    return createPostResponse;
  }
}
