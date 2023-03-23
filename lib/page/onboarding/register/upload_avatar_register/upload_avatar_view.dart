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
                      Container(
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
}
