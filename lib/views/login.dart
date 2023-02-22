import 'package:flutter/material.dart';

import '../assets/images_assets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                ImageAssets.imgLogo,
                width: 200,
                height: 200,
                color: Colors.black,
              ),
              Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(child: Icon(Icons.person))),
              SizedBox(height: 13),
              Text(
                'user',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Nunito Sans',
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),

              /// phone number
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'phone');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      'Số điện thoại',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Nunito Sans',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              /// facebook
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
