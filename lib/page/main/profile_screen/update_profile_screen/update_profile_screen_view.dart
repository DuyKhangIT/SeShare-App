import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/profile_screen/update_profile_screen/update_profile_controller.dart';

import '../../../../util/global.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UpdateProfileController updateProfileController =
        Get.put(UpdateProfileController());
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
                      Icons.close,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  title: Text(
                    "Chỉnh sửa trang cá nhân",
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
                          updateProfileController.updateUserProfile();
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
                        Column(
                          children: [
                            Global.userProfileResponse!.backgroundPath!.isNotEmpty
                            ?Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 20),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Image.network(Global.convertMedia(Global.userProfileResponse!.backgroundPath!, 400, 250),
                                    fit: BoxFit.cover))
                            :Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 20),
                                color: Colors.grey,),
                            const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Icon(Icons.arrow_downward_sharp),
                            ),
                            updateProfileController.background!=null
                            ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return detailBottomSheetAddBackGroundImage(
                                          updateProfileController);
                                    });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                                child: Image.file(updateProfileController.background!,fit: BoxFit.cover),
                              ),
                            )
                                :GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return detailBottomSheetAddBackGroundImage(
                                          updateProfileController);
                                    });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                margin:
                                const EdgeInsets.only(top: 10, bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                                child: Image.asset(IconsAssets.icUpload),
                              ),
                            ),
                          ],
                        ),
                        const Text("Chỉnh sửa ảnh bìa",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Global.userProfileResponse!.avatarPath!.isNotEmpty
                                ? Container(
                                    width: 80,
                                    height: 80,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                            Global.convertMedia(Global
                                                .userProfileResponse!
                                                .avatarPath!,80,80),
                                            fit: BoxFit.cover)))
                                : Container(
                                    width: 80,
                                    height: 80,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey,
                                    )),
                            const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Icon(Icons.arrow_forward),
                            ),
                            updateProfileController.avatar != null
                                ? GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return detailBottomSheetAddImage(
                                                updateProfileController);
                                          });
                                    },
                                    child: Container(
                                        width: 80,
                                        height: 80,
                                        margin: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.file(
                                                updateProfileController.avatar!,
                                                fit: BoxFit.cover))),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return detailBottomSheetAddImage(
                                                updateProfileController);
                                          });
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      margin: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                      child: Image.asset(IconsAssets.icUpload),
                                    ),
                                  ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return detailBottomSheetAddImage(
                                      updateProfileController);
                                });
                          },
                          child: const Text("Chỉnh sửa ảnh đại diện",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        textFieldFullName(updateProfileController),
                        textFieldBio(updateProfileController),
                        textFieldGender(updateProfileController),
                        textFieldBirthday(updateProfileController),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  /// text field full name
  Widget textFieldFullName(UpdateProfileController updateProfileController) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: updateProfileController.userNameController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        decoration: InputDecoration(
            labelText: "Tên",
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
            updateProfileController.userName = value;
            updateProfileController.update();
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

  /// text field bio
  Widget textFieldBio(UpdateProfileController updateProfileController) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: updateProfileController.bioController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        decoration: InputDecoration(
            labelText: "Tiểu sử",
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
            updateProfileController.bio = value;
            updateProfileController.update();
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
  Widget textFieldGender(UpdateProfileController updateProfileController) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: updateProfileController.genderController,
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
            updateProfileController.gender = value;
            updateProfileController.update();
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

  /// text field birthday
  Widget textFieldBirthday(UpdateProfileController updateProfileController) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: updateProfileController.birthDayController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
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
            updateProfileController.birthDay = value;
            updateProfileController.update();
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

  /// add image
  Widget detailBottomSheetAddImage(
      UpdateProfileController updateProfileController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.transparent,
              )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 31, right: 31, bottom: 26),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    updateProfileController.getImageFromCamera();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Chụp ảnh".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ),
                  )),
              Divider(
                thickness: 0.5,
                height: 0,
                color: Colors.black.withOpacity(0.1),
              ),
              InkWell(
                  onTap: () {
                    updateProfileController.getImageFromGallery();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Chọn ảnh từ thư viện".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ),
                  )),
            ],
          ),
        ),

        /// BUTTON CANCEL
        Padding(
            padding: const EdgeInsets.only(bottom: 34, left: 34, right: 34),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 4,
                  shadowColor: Colors.black,
                  side: const BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Hủy chọn".toUpperCase(),
                  style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2),
                ),
              ),
            ))
      ],
    );
  }

  /// add background image
  Widget detailBottomSheetAddBackGroundImage(
      UpdateProfileController updateProfileController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.transparent,
              )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 31, right: 31, bottom: 26),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    updateProfileController.getBackgroundImageFromCamera();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Chụp ảnh".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ),
                  )),
              Divider(
                thickness: 0.5,
                height: 0,
                color: Colors.black.withOpacity(0.1),
              ),
              InkWell(
                  onTap: () {
                    updateProfileController.getBackgroundImageFromGallery();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Chọn ảnh từ thư viện".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ),
                  )),
            ],
          ),
        ),

        /// BUTTON CANCEL
        Padding(
            padding: const EdgeInsets.only(bottom: 34, left: 34, right: 34),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 4,
                  shadowColor: Colors.black,
                  side: const BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Hủy chọn".toUpperCase(),
                  style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2),
                ),
              ),
            ))
      ],
    );
  }
}
