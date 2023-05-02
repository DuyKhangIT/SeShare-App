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
import 'package:instagram_app/models/user_profile/user_profile_response.dart';
import 'package:instagram_app/page/navigation_bar/navigation_bar_view.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/upload_media/upload_media_response.dart';
import '../../../../util/global.dart';

class UpdateProfileController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  String userName = "";
  String bio = "";
  String gender = "";
  bool isLoading = false;
  File? avatar;
  String filePath = "";
  String avatarPath = "";
  @override
  void onReady() {
    userNameController.text = Global.userProfileResponse!.fullName;
    bioController.text = Global.userProfileResponse!.bio!;
    genderController.text = Global.userProfileResponse!.gender!;
    avatarPath = Global.userProfileResponse!.avatarPath!;
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
      if(avatarPath.isNotEmpty){
        UpdateUserProfileRequest updateUserProfileRequest =
        UpdateUserProfileRequest(
            Global.userProfileResponse!.phone,
            Global.userProfileResponse!.password,
            genderController.text,
            userNameController.text,
            avatarPath,
            bioController.text);
        updateProfile(updateUserProfileRequest);
      }
    }
    return uploadMediaResponse;
  }

  void updateUserProfile() {
    if(filePath.isNotEmpty){
      uploadMedia();
    }else{
      UpdateUserProfileRequest updateUserProfileRequest =
      UpdateUserProfileRequest(
          Global.userProfileResponse!.phone,
          Global.userProfileResponse!.password,
          genderController.text,
          userNameController.text,
          avatarPath,
          bioController.text);
      updateProfile(updateUserProfileRequest);
    }

  }

  /// handle update user profile api
  Future<UserProfileResponse> updateProfile(
      UpdateUserProfileRequest updateUserProfileRequest) async {
    isLoading = true;
    if (isLoading) {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
    } else {
      Get.back(); // Đóng hộp thoại loading nếu isLoading = false
    }
    UserProfileResponse userProfileResponse;
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
    if (body == null) return UserProfileResponse.buildDefault();
    //get data from api here
    userProfileResponse = UserProfileResponse.fromJson(body);
    if (userProfileResponse.id.isNotEmpty) {
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
      Global.userProfileResponse = userProfileResponse;
      Get.offAll(() => const NavigationBarView());
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

    return userProfileResponse;
  }
}
