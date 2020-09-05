import 'dart:math';

import 'package:ClockIN/model/clock/util/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Foggy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherParticleAnimator(
          axis: Axis.horizontal,
          step: _fogStep,
          minAnimDelay: const Duration(seconds: 3),
          maxAnimDelay: const Duration(seconds: 10),
          minAnimDuration: const Duration(seconds: 1),
          maxAnimDuration: const Duration(seconds: 3),
          particleBuilder: (index, color, progress) => _FogPainter(
            index: index,
            color: color,
            progress: progress,
          ),
        ),
      ],
    );
  }
}

const _fogStep = 1.0;

final _rnd = Random(DateTime.now().millisecondsSinceEpoch);
final _positions = <int, Offset>{};
final _targetPositions = <int, Offset>{};

class _FogPainter extends CustomPainter {
  _FogPainter({
    @required this.index,
    @required this.color,
    @required this.progress,
  });

  final int index;
  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    double p = progress <= 0.5 ? progress : 1 - progress;
    p = p / 2;

    final m =
        _positions[index] ??= Offset(_rnd.nextDouble(), _rnd.nextDouble());

    final t = _targetPositions[index] ??= Offset(
      _rnd.nextDouble() * 0.2 - 0.1,
      _rnd.nextDouble() * 0.2 - 0.1,
    );

    final x = m.dx + t.dx * progress;
    final y = m.dy + t.dy * progress;

    final paint = Paint()..color = Colors.white.withOpacity(p);

    canvas.drawCircle(
        Offset(size.width * x, size.height * y), size.height / 2, paint);
  }

  @override
  bool shouldRepaint(_FogPainter oldDelegate) {
    return index != oldDelegate.index ||
        color != oldDelegate.color ||
        progress != oldDelegate.progress;
  }
}
