import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wollu/util/app_styles.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint()
      ..strokeWidth = 1.5
      ..color = const Color(0xFFDEE0F6)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height + 0.8);

    canvas.drawCircle(Offset(size.width/2,size.height/2), 145, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint

    return false;
  }

}

class ArcPainter extends CustomPainter {
  final gradient = LinearGradient(
      colors: [Color(0xFF616FEE), Color(0xFF9AE9CF), Color(0xFF9AE9CF), Color(0xFF9AE9CF),  Color(0xFFB2F02D),],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight
      )
      .createShader(Rect.fromCircle(center: Offset(150,150), radius: min(145 / 2 ,145/2)));
  double arcAngle = 2 * pi * (100/ 100);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint()
      ..strokeWidth = 145.0
      ..shader = gradient
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height);

    canvas.drawArc(Rect.fromCircle(center: Offset(size.width/2,size.height/2), radius: min(paint.strokeWidth / 2 ,paint.strokeWidth/2)),
        -pi / 2,
        arcAngle,
        false,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
  
}