import 'package:flutter/material.dart';

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    final double centerX = size.width / 2;
    final double notchRadius = 35;
    final double percentage = 0.60;
    Path path = Path();

    // top left corner
    // Start her like put pen her still not drawing
    path.moveTo(0, 0);

    // top line up to where the curve starts
    path.lineTo(centerX - notchRadius - 5, 0);

    path.quadraticBezierTo(
      centerX - notchRadius,
      size.height * percentage, // curve starting point x
      centerX,
      size.height * percentage,
    );

    path.quadraticBezierTo(
      centerX + notchRadius,
      size.height * percentage, // curve starting point x
      centerX + notchRadius + 5,
      0,
    );

    path.lineTo(size.width, 0);

    //
    path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
