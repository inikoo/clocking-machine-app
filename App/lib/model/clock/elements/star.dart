import 'dart:math' as math;

import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  final Color color;

  const Star({
    Key key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StarPainter(color),
    );
  }
}

class _StarPainter extends CustomPainter {
  final Color color;

  _StarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color;

    final min = math.min(size.width, size.height);
    final half = min / 2;
    final mid = size.width / 2 - half;

    final path = Path();

    // top left
    path.moveTo(mid + half * 0.5, half * 0.84);
    // top right
    path.lineTo(mid + half * 1.5, half * 0.84);
    // bottom left
    path.lineTo(mid + half * 0.68, half * 1.45);
    // top tip
    path.lineTo(mid + half * 1.0, half * 0.5);
    // bottom right
    path.lineTo(mid + half * 1.32, half * 1.45);
    // top left
    path.lineTo(mid + half * 0.5, half * 0.84);

    path.close();

    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(_StarPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
