import 'package:flutter/material.dart';

class ButtonNext extends StatelessWidget {
  final GestureTapCallback onTap;
  final String? textInside;
  final Widget? icon;

  const ButtonNext({
    Key? key,
    required this.onTap,
    this.textInside,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: 1, style: BorderStyle.solid, color: Colors.white)),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xffFFFFFF).withOpacity(0.4),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? icon! : const SizedBox(),
            icon != null ? SizedBox(width: 8) : const SizedBox(),
            Text(
              "$textInside",
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'NunitoSans',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
