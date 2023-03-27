import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarCircle extends StatelessWidget {
  final onTap;
  final String image;
  AvatarCircle({Key? key, this.onTap, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
          width: 70,
          height: 70,
          margin: const EdgeInsets.only(top: 8, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue,
              width: 3.0,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
