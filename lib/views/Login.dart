import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
const   LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Đăng nhập vào Instagram',
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Nunito Sans',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Quản lý tài khoản, kiểm tra thông báo, bình luận trên các video,...',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: '',
                      color: Colors.black.withOpacity(0.3),
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),

              /// phone number
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const InputPhoneNumber()),
                  // );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.person_outline,
                        color: Colors.black,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Số điện thoại',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nunito Sans',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// facebook
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                      width: 1,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Tiếp tục với Facebook',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nunito Sans',
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),

              /// google
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                      width: 1,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Tiếp tục với Google',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nunito Sans',
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Bạn không có tài khoản?',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito Sans',
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Đăng ký',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito Sans',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
