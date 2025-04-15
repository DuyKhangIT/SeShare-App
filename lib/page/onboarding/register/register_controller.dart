import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../util/global.dart';

class RegisterController extends GetxController {
  bool isLoading = false;
  TextEditingController fullNameController = TextEditingController();
  RxString fullName = RxString("");

  TextEditingController passwordController = TextEditingController();
  RxString password = RxString("");
  RxBool isShowPassword = false.obs;

  TextEditingController confirmPasswordController = TextEditingController();
  RxString confirmPassword = RxString("");
  RxBool isConfirmShowPassword = false.obs;

  File? avatar;


  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  RxString day = RxString("");
  RxString month = RxString("");
  RxString year = RxString("");
  String birthDay = "";

  void clearTextFullName() {
    fullName.value = "";
    fullNameController.clear();
  }

  void clearTextInputPassword() {
    password.value = "";
    passwordController.clear();
  }

  void clearTextInputConfirmPassword() {
    confirmPassword.value = "";
    confirmPasswordController.clear();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    fullName.value = "";
    fullNameController.clear();
    passwordController.text = "";
    password.value = "";
    confirmPasswordController.text = "";
    confirmPassword.value = "";
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
