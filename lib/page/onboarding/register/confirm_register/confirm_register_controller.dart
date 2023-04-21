import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/register_response/confirm_register/confirm_register_request.dart';
import 'package:instagram_app/models/register_response/confirm_register/confirm_register_response.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../util/global.dart';
import 'package:http/http.dart' as http;

import '../../login/login_view.dart';

class ConfirmRegisterController extends GetxController {
  bool isLoading = false;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> confirmRegister() async {
    isLoading = true;
    if (isLoading) {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    } else {
      Get.back();
    }
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://cndk-seshare.up.railway.app/api/user/sign-up'));
    request.fields.addAll({
      'phone': Global.phoneNumber,
      'password': Global.registerNewPassword,
      'fullName': Global.registerNewFullName
    });
    request.files.add(await http.MultipartFile.fromPath('avatar', Global.registerNewAvatar));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      isLoading = false;
      if (isLoading) {
        Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      } else {
        Get.back();
      }
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Thành công!',
          message: "Bạn đã đăng ký thành công",
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      Get.offAll(() => Login());
    }
    else {
      print(response.reasonPhrase);
      isLoading = false;
      if (isLoading) {
        Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      } else {
        Get.back();
      }
    }

  }
}
