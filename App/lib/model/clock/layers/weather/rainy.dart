import 'package:ClockIN/model/clock/elements/clouds.dart';
import 'package:ClockIN/model/clock/util/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Rain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherParticleAnimator(
      axis: Axis.vertical,
      step: _raindropStep,
      minAnimDuration: const Duration(milliseconds: 500),
      maxAnimDuration: const Duration(seconds: 1),
      particleBuilder: (index, color, progress) => _RaindropPainter(
        index: index,
        color: color,
        progress: progress,
      ),
    );
  }
}

class RainyWithClouds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Rain(),
        Clouds(type: CloudType.rain),
      ],
    );
  }
}

const _raindropStep = 16.0;
const _raindropWidth = 8.0;
const _raindropHeight = _raindropWidth * 5;

class _RaindropPainter extends CustomPainter {
  _RaindropPainter({
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
    final rect = RRect.fromLTRBR(0, 0, _raindropWidth, _raindropHeight,
        Radius.circular(_raindropWidth / 2));

    canvas.save();
    canvas.translate(index * _raindropStep, size.height * progress);
    canvas.drawRRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_RaindropPainter oldDelegate) {
    return index != oldDelegate.index ||
        color != oldDelegate.color ||
        progress != oldDelegate.progress;
  }
}
