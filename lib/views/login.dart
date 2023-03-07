import 'package:flutter/material.dart';
import '../util/global.dart';

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
              const Text(
                'Images',
                style: TextStyle(
                  fontSize: 49,
                  fontFamily: 'Nunito Sans',
                ),
              ),
              Container(
                  width: 85,
                  height: 85,
                  margin: const EdgeInsets.only(top: 52),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: const ClipOval(child: Icon(Icons.person))),
              const SizedBox(height: 13),
              const Text(
                'Khang',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'phone');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Global.blueColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Số điện thoại',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Đổi tài khoản',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
