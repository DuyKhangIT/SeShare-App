import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarStory extends StatelessWidget {
  final onTap;
  final String image;
  AvatarStory({Key? key, this.onTap, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child:  Container(
          width: 65,
          height: 65,
          margin: const EdgeInsets.only(top: 8, bottom: 5),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
