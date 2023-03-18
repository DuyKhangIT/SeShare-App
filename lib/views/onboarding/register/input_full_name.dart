import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/views/onboarding/register/upload_avatar_for_register.dart';

import '../../../widget/button_next.dart';

class InputFullName extends StatefulWidget {
  const InputFullName({Key? key}) : super(key: key);

  @override
  State<InputFullName> createState() => _InputFullNameState();
}

class _InputFullNameState extends State<InputFullName> {
  TextEditingController fullNameController = TextEditingController();
  String fullName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void clearText() {
    setState(() {
      fullNameController.clear();
      fullName = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Đăng ký',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).textTheme.headline6?.color,
                fontSize: 20),
          ),
          centerTitle: true ,
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          child: Column(
            children: [
              const Text('Tên của bạn là gì',
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
                  'Nhập tên của bạn để bạn bè có thể dễ dàng tìm thấy bạn',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center),

              /// text field
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                ),
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.only(left: 16, right: 10),
                child: TextField(
                  controller: fullNameController,
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Tên của bạn',
                      hintStyle: const TextStyle(
                        fontFamily: 'NunitoSans',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      counterText: '',
                      suffixIcon: (fullNameController.text.isEmpty)
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                clearText();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Image.asset(
                                  IconsAssets.icClearText,
                                ),
                              ),
                            )),
                  onChanged: (value) {
                    setState(() {
                      fullName = value;
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
              ),

              /// button
              ButtonNext(
                onTap: () {
                  Get.to(() => const UploadAvatarForRegister());
                },
                textInside: "Tiếp tục".toUpperCase(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
