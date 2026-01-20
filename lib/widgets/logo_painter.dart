import 'package:flutter/material.dart';

class LogoPainter extends CustomPainter {
  final Color color;
  LogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Using simple points to approximate the U-shaped logo from the image
    // The logo is a stylized 'U' with rounded ends and thick strokes.

    path.moveTo(size.width * 0.2, size.height * 0.1);
    path.lineTo(size.width * 0.2, size.height * 0.7);

    path.arcToPoint(
      Offset(size.width * 0.8, size.height * 0.7),
      radius: Radius.circular(size.width * 0.3),
      clockwise: false,
    );

    path.lineTo(size.width * 0.8, size.height * 0.1);

    // Inner path for the hole
    final innerPath = Path();
    innerPath.moveTo(size.width * 0.4, size.height * 0.1);
    innerPath.lineTo(size.width * 0.4, size.height * 0.7);

    innerPath.arcToPoint(
      Offset(size.width * 0.6, size.height * 0.7),
      radius: Radius.circular(size.width * 0.1),
      clockwise: false,
    );

    innerPath.lineTo(size.width * 0.6, size.height * 0.1);

    // Combine paths (subtracting inner from outer)
    final finalPath = Path.combine(PathOperation.difference, path, innerPath);

    canvas.drawPath(finalPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
