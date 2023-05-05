import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/main/profile_screen/setting_screen/change_password/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    ChangePasswordController changePasswordController =
        Get.put(ChangePasswordController());
    return GetBuilder<ChangePasswordController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close,
                      color: Theme.of(context).textTheme.headline6?.color),
                ),
                title: Text("Đổi mật khẩu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito Sans',
                      fontSize: 20,
                      color: Theme.of(context).textTheme.headline6?.color,
                    )),
                actions: [
                  InkWell(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(Icons.check,
                          color: Theme.of(context).textTheme.headline6?.color),
                    ),
                  )
                ],
                elevation: 0,
              ),
              body: SafeArea(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mật khẩu của bạn có ít nhất 6 kí tự, đồng thời bao gồm cả chữ số, chữ cái và kí tự đặc biệt",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Nunito Sans',
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black.withOpacity(0.6)),
                    ),
                    const SizedBox(height: 20),
                    textFieldOldPassword(changePasswordController),
                    textFieldNewPassword(changePasswordController),
                    textFieldConfirmNewPassword(changePasswordController)
                  ],
                ),
              )),
            ));
  }

  /// text field old password
  Widget textFieldOldPassword(
      ChangePasswordController changePasswordController) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 25),
      child: TextField(
        controller: changePasswordController.oldPasswordController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
        ],
        decoration: InputDecoration(
            labelText: "Mật khẩu hiện tại",
            labelStyle: TextStyle(
                fontFamily: 'Nunito Sans',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))),
        onChanged: (value) {
          setState(() {
            changePasswordController.oldPassword = value;
            changePasswordController.update();
          });
        },
        style: const TextStyle(
            color: Colors.black,
            fontFamily: 'NunitoSans',
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            height: 1.9),
      ),
    );
  }

  /// text field gender
  Widget textFieldNewPassword(
      ChangePasswordController changePasswordController) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 25),
      child: TextField(
        controller: changePasswordController.newPasswordController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
        ],
        decoration: InputDecoration(
            labelText: "Nhập mật khẩu mới",
            labelStyle: TextStyle(
                fontFamily: 'Nunito Sans',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))),
        onChanged: (value) {
          setState(() {
            changePasswordController.newPassword = value;
            changePasswordController.update();
          });
        },
        style: const TextStyle(
            color: Colors.black,
            fontFamily: 'NunitoSans',
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            height: 1.9),
      ),
    );
  }

  /// text field gender
  Widget textFieldConfirmNewPassword(
      ChangePasswordController changePasswordController) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 25),
      child: TextField(
        controller: changePasswordController.confirmNewPasswordController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
        ],
        decoration: InputDecoration(
            labelText: "Nhập lại mật khẩu mới",
            labelStyle: TextStyle(
                fontFamily: 'Nunito Sans',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))),
        onChanged: (value) {
          setState(() {
            changePasswordController.confirmNewPassword = value;
            changePasswordController.update();
          });
        },
        style: const TextStyle(
            color: Colors.black,
            fontFamily: 'NunitoSans',
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            height: 1.9),
      ),
    );
  }
}
