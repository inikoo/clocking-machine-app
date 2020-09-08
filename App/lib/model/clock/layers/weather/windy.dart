import 'package:ClockIN/model/clock/util/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Windy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherParticleAnimator(
      axis: Axis.horizontal,
      step: _windStreamStep,
      minAnimDuration: Duration(milliseconds: 500),
      maxAnimDuration: Duration(seconds: 2),
      particleBuilder: (index, color, progress) => _WindPainter(
        index: index,
        color: color,
        progress: progress,
      ),
    );
  }
}

const _windStreamStep = 16.0;
const _windStreamWidth = _windStreamHeight * 16.0;
const _windStreamHeight = 8.0;

class _WindPainter extends CustomPainter {
  _WindPainter({
    @required this.index,
    @required this.color,
    @required this.progress,
  });

  final int index;
  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    double opacity;
    if (progress < 0.2) {
      opacity = progress * 5;
    } else {
      opacity = 1 - progress;
    }

    final paint = Paint()..color = color.withOpacity(opacity);
    final rect = RRect.fromLTRBR(0, 0, _windStreamWidth, _windStreamHeight,
        Radius.circular(_windStreamWidth / 2));

    canvas.save();
    canvas.translate(size.width * progress - _windStreamWidth * (1 - progress),
        index * _windStreamStep);
    canvas.drawRRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_WindPainter oldDelegate) {
    return index != oldDelegate.index ||
        color != oldDelegate.color ||
        progress != oldDelegate.progress;
  }
}
