import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/main/profile_screen/update_profile_screen/update_private_info/update_private_info_controller.dart';
import 'package:instagram_app/page/main/profile_screen/update_profile_screen/update_profile_controller.dart';

import '../../../../../util/global.dart';

class UpdatePrivateInfoScreen extends StatefulWidget {
  const UpdatePrivateInfoScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePrivateInfoScreen> createState() =>
      _UpdatePrivateInfoScreenState();
}

class _UpdatePrivateInfoScreenState extends State<UpdatePrivateInfoScreen> {
  @override
  Widget build(BuildContext context) {
    UpdatePrivateInfoController updatePrivateInfoController =
        Get.put(UpdatePrivateInfoController());
    return GetBuilder<UpdateProfileController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.white,
                appBar: AppBar(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.black54
                          : Colors.white,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  title: Text(
                    "Thông tin cá nhân",
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontSize: 18),
                  ),
                  centerTitle: true,
                  actions: [
                    GestureDetector(
                      onTap: () {
                        if (Global.isAvailableToClick()) {
                          updatePrivateInfoController.updateUserProfile();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    )
                  ],
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(20),
                          child: const Text(
                            "Cung cấp thông tin cá nhân của bạn, kể cá khi đây là tài khoản dành cho chủ thể nào đó như doanh nghiệp hoặc thú cưng. Thông tin này sẽ không hiển thị trên trang cá nhân công khai của bạn.",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Nunito Sans',
                                height: 1.2),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        textFieldPhoneNumber(updatePrivateInfoController),
                        textFieldPlace(updatePrivateInfoController),
                        textFieldGender(updatePrivateInfoController),
                        textFieldBirthday(updatePrivateInfoController),

                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
  Widget textFieldPhoneNumber(
      UpdatePrivateInfoController updatePrivateInfoController) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: updatePrivateInfoController.phoneNumberController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        readOnly: true,
        decoration: InputDecoration(
            labelText: "Số điện thoại",
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
        style:  TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontFamily: 'NunitoSans',
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            height: 1.9),
      ),
    );
  }
  /// text field place
  Widget textFieldPlace(
      UpdatePrivateInfoController updatePrivateInfoController) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: updatePrivateInfoController.placeController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            labelText: "Địa chỉ hiện tại",
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
            updatePrivateInfoController.place = value;
            updatePrivateInfoController.update();
          });
        },
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontFamily: 'NunitoSans',
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            height: 1.9),
      ),
    );
  }

  /// text field gender
  Widget textFieldGender(
      UpdatePrivateInfoController updatePrivateInfoController) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: updatePrivateInfoController.genderController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        decoration: InputDecoration(
            labelText: "Giới tính",
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
            updatePrivateInfoController.gender = value;
            updatePrivateInfoController.update();
          });
        },
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontFamily: 'NunitoSans',
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            height: 1.9),
      ),
    );
  }

  /// text field birthday
  Widget textFieldBirthday(
      UpdatePrivateInfoController updatePrivateInfoController) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: updatePrivateInfoController.birthDayController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        decoration: InputDecoration(
            labelText: "Sinh nhật",
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
            updatePrivateInfoController.birthDay = value;
            updatePrivateInfoController.update();
          });
        },
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontFamily: 'NunitoSans',
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            height: 1.9),
      ),
    );
  }


}
