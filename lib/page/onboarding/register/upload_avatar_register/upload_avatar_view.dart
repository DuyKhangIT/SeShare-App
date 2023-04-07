import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_app/page/onboarding/register/upload_avatar_register/upload_avatar_controller.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../widget/button_next.dart';
import '../confirm_register/confirm_register_view.dart';

class UploadAvatarForRegister extends StatefulWidget {
  const UploadAvatarForRegister({Key? key}) : super(key: key);

  @override
  State<UploadAvatarForRegister> createState() =>
      _UploadAvatarForRegisterState();
}

class _UploadAvatarForRegisterState extends State<UploadAvatarForRegister> {
  UploadAvatarController uploadAvatarController =
      Get.put(UploadAvatarController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadAvatarController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Đăng ký',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).textTheme.headline6?.color,
                        fontSize: 20),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                    ),
                  ),
                  elevation: 0,
                ),
                resizeToAvoidBottomInset: false,
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Ảnh đại diện của bạn',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                          'Bạn có thể cập nhật ảnh đại diện của bạn tại đây',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center),
                      (uploadAvatarController.avatar != null)
                      ? InkWell(
                        onTap: (){
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return detailBottomSheet(controller);
                              });
                        },
                        child: Stack(
                          children: [
                            Container(
                                width: 157,
                                height: 157,
                                margin: const EdgeInsets.only(top: 80),
                                decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                                child: ClipOval(
                                  child: Image.file(
                                    uploadAvatarController.avatar!,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Image.asset(IconsAssets.icPen,
                                        height: 16, width: 16)),
                              ),
                            )
                          ],
                        ),
                      )
                      : InkWell(
                        onTap: (){
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return detailBottomSheet(controller);
                              });
                        },
                        child: Container(
                            width: 157,
                            height: 157,
                            margin: const EdgeInsets.only(top: 80),
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: DottedBorder(
                                color: Colors.black.withOpacity(0.5),
                                strokeWidth: 1,
                                borderType: BorderType.Circle,
                                dashPattern: const [6, 5],
                                radius: const Radius.circular(60),
                                child: Center(
                                    child: Image.asset(IconsAssets.icUpload)))),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 80),
                          child: ButtonNext(
                            onTap: () {
                              Get.to(() => const ConfirmRegister());
                            },
                            textInside: 'tiếp tục'.toUpperCase(),
                          ))
                    ],
                  ),
                ),

                /// button next ///
              ),
            ));
  }

  Widget detailBottomSheet(UploadAvatarController uploadAvatarController) {
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
          margin: EdgeInsets.only(left: 31, right: 31, bottom: 26),
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    uploadAvatarController.getImageFromCamera();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Chụp ảnh".toUpperCase(),
                          style: TextStyle(
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
                    uploadAvatarController.getImageFromGallery();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                         "Chọn ảnh từ thư viện"
                              .toUpperCase(),
                          style: TextStyle(
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
            padding: EdgeInsets.only(bottom: 34,left: 34,right: 34),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blue,
                  elevation: 4,
                  shadowColor: Colors.black,
                  side: BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Hủy chọn".toUpperCase(),
                  style: TextStyle(
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
