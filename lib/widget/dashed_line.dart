import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final double dashLenght;
  final double dashSpace;
  final double strokeWidth;
  final bool isHorizontal;
  final Color? color;

  DashedLinePainter({
    required this.dashLenght,
    required this.dashSpace,
    required this.strokeWidth,
    this.isHorizontal = false,
    this.color,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    double startY = 0;

    final paint = Paint()
      ..color = color ?? Colors.black
      ..strokeWidth = strokeWidth;

    if (isHorizontal) {
      while (startX < size.width) {
        canvas.drawLine(
            Offset(startX, 0), Offset(startX + dashLenght, 0), paint);
        startX += dashLenght + dashSpace;
      }
    } else {
      while (startY < size.height) {
        canvas.drawLine(
            Offset(0, startY), Offset(0, startY + dashLenght), paint);
        startY += dashLenght + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
