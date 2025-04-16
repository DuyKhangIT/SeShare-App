import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/models/register/register_request.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;
import '../../../util/global.dart';
import '../login/login_view.dart';

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

  // /// REGISTER
  Future<void> register(
    RegisterRequest registerRequest,
  ) async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      final uri = Uri.parse("http://10.0.2.2:5000/api/auth/register");
      final request = http.MultipartRequest('POST', uri);

      // Thêm các fields của bạn (không phải file)
      request.fields['email'] = registerRequest.mEmail;
      request.fields['password'] = registerRequest.mPassword;
      request.fields['fullName'] = registerRequest.mFullName;

      if (avatar != null) {
        // Đọc file + đuôi đúng
        final mimeType = lookupMimeType(avatar!.path) ?? 'image/jpeg';
        final fileStream = http.MultipartFile.fromBytes(
          'avatar',
          await avatar!.readAsBytes(),
          filename: avatar!.path.split('/').last, // ví dụ: avatar.jpg
          contentType: MediaType.parse(mimeType),
        );

        request.files.add(fileStream);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        Get.offAll(Login());
      } else {
        // xử lý lỗi
        throw Exception("Đăng ký thất bại: ${response.body}");
      }
    } catch (error) {
      Get.back();
      debugPrint("Fail to send otp: $error");
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Cảnh báo!',
          message: error.toString(),
          contentType: ContentType.help,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      rethrow;
    }

    return;
  }
}
