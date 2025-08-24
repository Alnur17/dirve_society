import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CustomMarkerPainter extends CustomPainter {
  final ui.Image image;
  final Color markerColor;
  final Color strokeColor;

  CustomMarkerPainter({
    required this.image,
    required this.markerColor,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    final double circleRadius = width / 3;
    final double circleTop = 0;
    final double circleCenter = width / 3;

    // Draw shadow
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Shadow path
    final Path shadowPath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(circleCenter + 2, circleRadius + 2),
          radius: circleRadius))
      ..moveTo(circleCenter + 2, circleRadius * 2 + 2)
      ..lineTo(circleCenter + 2, height - 10)
      ..lineTo(circleCenter + 15, height - 30)
      ..lineTo(circleCenter - 15, height - 30)
      ..close();

    canvas.drawPath(shadowPath, shadowPaint);

    // Draw the pin/spike
    final Paint pinPaint = Paint()
      ..color = markerColor
      ..style = PaintingStyle.fill;

    // Main pin path
    final Path pinPath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(circleCenter, circleRadius), radius: circleRadius))
      ..moveTo(circleCenter, circleRadius * 2)
      ..lineTo(circleCenter, height - 10)
      ..lineTo(circleCenter + 12, height - 30)
      ..lineTo(circleCenter - 12, height - 30)
      ..close();

    canvas.drawPath(pinPath, pinPaint);

    // Draw stroke around the marker
    final Paint strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(pinPath, strokePaint);

    // Clip for the image - just the circle part
    canvas.save();
    canvas.clipPath(Path()
      ..addOval(Rect.fromCircle(
          center: Offset(circleCenter, circleRadius),
          radius: circleRadius - 5)));

    // Draw the image inside the circle
    final double imageSize = (circleRadius - 5) * 2;
    final Rect imageRect = Rect.fromLTWH(
      5,
      5,
      imageSize,
      imageSize,
    );

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      imageRect,
      Paint(),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}