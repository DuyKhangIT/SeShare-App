import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/models/update_user_profile/update_user_profile_request.dart';
import 'package:instagram_app/page/navigation_bar/navigation_bar_view.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/upload_media/upload_media_response.dart';
import '../../../../models/user_profile/profile_response.dart';
import '../../../../util/global.dart';

class UpdateProfileController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  String userName = "";
  String bio = "";
  String gender = "";
  String birthDay = "";
  bool isLoading = false;
  File? avatar;
  String filePath = "";
  String avatarPath = "";
  File? background;
  String fileBackgroundPath = "";
  String backgroundPath = "";
  @override
  void onReady() {
    userNameController.text = Global.userProfileResponse!.fullName;
    bioController.text = Global.userProfileResponse!.bio!;
    genderController.text = Global.userProfileResponse!.gender!;
    avatarPath = Global.userProfileResponse!.avatarPath!;
    backgroundPath = Global.userProfileResponse!.backgroundPath!;
    birthDayController.text = Global.userProfileResponse!.age;
    update();
    super.onReady();
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

  /////////////////////////////

  /// function to get the Background image from the camera
  Future getBackgroundImageFromCamera() async {
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
    background = picture;
    Navigator.pop(Get.context!);

    String filePaths;
    filePaths = picture.path;
    fileBackgroundPath = filePaths;
    update();
  }

  /// function to get the Background image from the gallery
  Future getBackgroundImageFromGallery() async {
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
    background = imgFrame;
    Navigator.pop(Get.context!);

    String filePaths;
    filePaths = imgFrame.path;
    fileBackgroundPath = filePaths;
    update();
  }

  /// function to adjustment the Background image frame
  Future<File?> cropperBackgroundImage({required File imgFile}) async {
    CroppedFile? cropperImage =
        await ImageCropper().cropImage(sourcePath: imgFile.path);
    if (cropperImage == null) return null;
    return File(cropperImage.path);
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
      avatarPath = uploadMediaResponse.data!;
      update();
      if (avatarPath.isNotEmpty) {
        UpdateUserProfileRequest updateUserProfileRequest =
            UpdateUserProfileRequest(
                genderController.text,
                userNameController.text,
                avatarPath,
                bioController.text,
                backgroundPath,
                birthDayController.text);
        updateProfile(updateUserProfileRequest);
        update();
      }
    }
    return uploadMediaResponse;
  }

  /// upload background image api
  Future<UploadMediaResponse> uploadBackground() async {
    UploadMediaResponse uploadMediaResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeSingleFile(
          Uri.parse("http://14.225.204.248:8080/api/photo/upload"),
          RequestType.post,
          fileBackgroundPath,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to upload file ${(error)}");
      rethrow;
    }
    if (body == null) return UploadMediaResponse.buildDefault();
    uploadMediaResponse = UploadMediaResponse.fromJson(body);
    if (uploadMediaResponse.status == true) {
      backgroundPath = uploadMediaResponse.data!;
      update();
      if (backgroundPath.isNotEmpty) {
        UpdateUserProfileRequest updateUserProfileRequest =
            UpdateUserProfileRequest(
                genderController.text,
                userNameController.text,
                avatarPath,
                bioController.text,
                backgroundPath,
                birthDayController.text);
        updateProfile(updateUserProfileRequest);
        update();
      }
    }
    return uploadMediaResponse;
  }

  void updateUserProfile() {
    if (filePath.isNotEmpty && fileBackgroundPath.isNotEmpty) {
      uploadMedia();
      uploadBackground();
    } else if (fileBackgroundPath.isNotEmpty) {
      uploadBackground();
    } else if (filePath.isNotEmpty) {
      uploadMedia();
    } else {
      UpdateUserProfileRequest updateUserProfileRequest =
          UpdateUserProfileRequest(
              genderController.text,
              userNameController.text,
              avatarPath,
              bioController.text,
              backgroundPath,
              birthDayController.text);
      updateProfile(updateUserProfileRequest);
    }
  }

  /// handle update user profile api
  Future<ProfileResponse> updateProfile(
      UpdateUserProfileRequest updateUserProfileRequest) async {
    isLoading = true;
    if (isLoading) {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
    } else {
      Get.back(); // Đóng hộp thoại loading nếu isLoading = false
    }
    ProfileResponse profileResponse;
    Map<String, dynamic>? body;
    //is this for string query only
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/user/updale-profile"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(updateUserProfileRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to update user profile $error");
      rethrow;
    }
    if (body == null) return ProfileResponse.buildDefault();
    //get data from api here
    profileResponse = ProfileResponse.fromJson(body);
    if (profileResponse.status == true) {
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
          message: "Cập nhật trang cá nhân thành công",
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      Global.userProfileResponse = profileResponse.userProfileResponse;
      Get.offAll(() => NavigationBarView(currentIndex: 4));
    } else {
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
          title: 'Thất bại!',
          message: "Cập nhật trang cá nhân thất bại",
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    return profileResponse;
  }
}
