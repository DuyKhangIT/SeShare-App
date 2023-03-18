import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/widget/button_next.dart';

import '../../../util/global.dart';

class InputPhoneNumber extends StatefulWidget {
  const InputPhoneNumber({Key? key}) : super(key: key);
  static String verify = "";
  @override
  State<InputPhoneNumber> createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {
  TextEditingController countryCode = TextEditingController();
  var phone = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    countryCode.text = "+84";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SeShare',
              style: TextStyle(
                fontSize: 49,
                fontFamily: 'Nunito Sans',
                fontStyle: FontStyle.italic
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Bạn cần nhập số điện thoại để chúng tôi có thể gửi mã otp cho bạn!",
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 40,
                    child: TextField(
                      controller: countryCode,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: VerticalDivider(
                      width: 10,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    onChanged: (value) {
                      phone = value;
                      Global.phoneNumber = phone;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Số điện thoại",
                    ),
                  ))
                ],
              ),
            ),
            const SizedBox(height: 20),
            /// Button Next
            ButtonNext(
              onTap: () async {
                if (phone.isEmpty) {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.fixed,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Lỗi!',
                      message: 'Bạn chưa nhập số điện thoại!',
                      contentType: ContentType.failure,
                    ),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                } else {
                  await auth.verifyPhoneNumber(
                    phoneNumber: countryCode.text + phone,
                    timeout: const Duration(seconds: 60),
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Lỗi!',
                          message: 'Gửi mã otp không thành công!',
                          contentType: ContentType.failure,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      InputPhoneNumber.verify = verificationId;
                      Navigator.pushNamed(context, 'otp');
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Cảnh báo!',
                          message: 'OTP đã hết hạn!',
                          contentType: ContentType.help,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    },
                  );
                }
              },
              textInside: "Gửi mã",
            ),
          ],
        ),
      ),
    );
  }
}
