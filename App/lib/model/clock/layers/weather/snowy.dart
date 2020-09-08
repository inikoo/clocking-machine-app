import 'package:ClockIN/model/clock/util/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Snowy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WeatherParticleAnimator(
          axis: Axis.vertical,
          step: _snowflakeStep,
          minAnimDelay: const Duration(),
          maxAnimDelay: const Duration(seconds: 3),
          particleBuilder: (index, color, progress) => _SnowflakePainter(
            index: index,
            color: color,
            progress: progress,
          ),
        ),
//        Clouds(type: CloudType.snow),
      ],
    );
  }
}

const _snowflakeStep = 8.0;
const _snowflakeWidth = 8.0;

class _SnowflakePainter extends CustomPainter {
  _SnowflakePainter({
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
      opacity = progress * 4;
    } else {
      opacity = 1 - progress;
    }

    final paint = Paint()..color = color.withOpacity(opacity);

    canvas.save();
    canvas.translate(index * _snowflakeStep, size.height * 1.5 * progress);
    canvas.drawCircle(Offset(_snowflakeWidth / 2, 0), 8, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_SnowflakePainter oldDelegate) {
    return index != oldDelegate.index ||
        color != oldDelegate.color ||
        progress != oldDelegate.progress;
  }
}
