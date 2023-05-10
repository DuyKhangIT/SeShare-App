import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/register_response/confirm_register/confirm_register_request.dart';
import 'package:instagram_app/models/register_response/confirm_register/confirm_register_response.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/upload_media/upload_media_response.dart';
import '../../../../util/global.dart';

import '../../login/login_view.dart';

class ConfirmRegisterController extends GetxController {
  bool isLoading = false;
  String filePath = "";
  String newAvatar = "";
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void signUp() {
    if (Global.registerNewAvatar.isNotEmpty) {
      filePath = Global.registerNewAvatar;
      uploadMediaWithoutToken();
    } else {
      ConfirmRegisterRequest confirmRegisterRequest = ConfirmRegisterRequest(
          Global.phoneNumber,
          Global.registerNewPassword,
          Global.registerNewFullName,
          Global.registerNewBirthday,
          newAvatar);
      confirmRegister(confirmRegisterRequest);
    }
  }

  /// upload image without token api
  Future<UploadMediaResponse> uploadMediaWithoutToken() async {
    UploadMediaResponse uploadMediaResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeSingleFile(
          Uri.parse("http://14.225.204.248:8080/api/upload-without-token"),
          RequestType.post,
          filePath,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to upload file without token ${(error)}");
      rethrow;
    }
    if (body == null) return UploadMediaResponse.buildDefault();
    uploadMediaResponse = UploadMediaResponse.fromJson(body);
    if (uploadMediaResponse.status == true) {
      newAvatar = uploadMediaResponse.data!;
      update();
      if (newAvatar.isNotEmpty) {
        ConfirmRegisterRequest confirmRegisterRequest = ConfirmRegisterRequest(
            Global.phoneNumber,
            Global.registerNewPassword,
            Global.registerNewFullName,
            Global.registerNewBirthday,
            newAvatar);
        confirmRegister(confirmRegisterRequest);
      }
    }
    return uploadMediaResponse;
  }

  Future<ConfirmRegisterResponse> confirmRegister(
      ConfirmRegisterRequest confirmRegisterRequest) async {
    isLoading = true;
    if (isLoading) {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
    } else {
      Get.back();
    }
    ConfirmRegisterResponse confirmRegisterResponse;
    Map<String, dynamic>? body;
    //is this for string query only
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/sign-up"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(confirmRegisterRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to sign up $error");
      rethrow;
    }
    if (body == null) return ConfirmRegisterResponse.buildDefault();
    //get data from api here
    confirmRegisterResponse = ConfirmRegisterResponse.fromJson(body);
    if (confirmRegisterResponse.mStatus == true) {
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
          title: 'Thành Công!',
          message: "Đăng ký thành công",
          contentType: ContentType.warning,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      Get.offAll(() => Login());
    }else{
      debugPrint("fail");
    }
    return confirmRegisterResponse;
  }
}
