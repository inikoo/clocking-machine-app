import 'dart:math';
import 'dart:ui' as ui;

import 'package:ClockIN/model/clock/elements/clouds.dart';
import 'package:ClockIN/model/clock/layers/weather/rainy.dart';
import 'package:ClockIN/model/clock/util/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Thunderstorm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Rain(),
        WeatherParticleAnimator(
          axis: Axis.vertical,
          step: _lightningWidth,
          minAnimDuration: Duration(milliseconds: 500),
          maxAnimDuration: Duration(milliseconds: 2000),
          maxAnimDelay: Duration(seconds: 10),
          particleBuilder: (index, color, progress) => _LightningPainter(
            index: index,
            color: color,
            progress: progress,
          ),
        ),
        Clouds(type: CloudType.rain),
      ],
    );
  }
}

const _lightningWidth = 64.0;

const _lightnings = [
  [
    Point(0.00, 0),
    Point(0.66, 0.3),
    Point(0.33, 0.6),
    Point(1.00, 1.0),
    Point(0.45, 0.6),
    Point(0.75, 0.3),
    Point(0.12, 0),
  ],
  [
    Point(0.75, 0),
    Point(0.33, 0.3),
    Point(0.66, 0.6),
    Point(0.00, 1.0),
    Point(0.75, 0.6),
    Point(0.50, 0.3),
    Point(0.96, 0),
  ],
];

const _splashes = <List<double>>[
  [0, 0.2, 0.05, 0.4, 0.1, 0.33, 0.2, 0, 0, 0],
];

final _rnd = Random(DateTime.now().millisecondsSinceEpoch);

/// Index -> lightning type mapping
final _lightningTypes = <int, int>{};

/// Index -> lightning type mapping
final _splashTypes = <int, int>{};

class _LightningPainter extends CustomPainter {
  _LightningPainter({
    @required this.index,
    @required this.color,
    @required this.progress,
  });

  final int index;
  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final lightningType =
        _lightningTypes[index] ??= _rnd.nextInt(1000000) % _lightnings.length;
    final splashType =
        _splashTypes[index] ??= _rnd.nextInt(1000000) % _splashes.length;

    final splashOpacities = _splashes[splashType];
    final splashOpacity =
        splashOpacities[(progress * (splashOpacities.length - 1)).floor()];
    final splashPaint = new Paint()
      ..shader = ui.Gradient.linear(
        Offset(0.0, 0.0),
        Offset(0.0, size.height),
        [
          Colors.white.withOpacity(0),
          Colors.white.withOpacity(splashOpacity),
          Colors.white.withOpacity(0),
        ],
        [0, 0.5, 1.0],
      );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      splashPaint,
    );

    double opacity;
    if (progress > 0.8) {
      opacity = (1 - progress) * 5;
    } else {
      opacity = progress + 0.2 * progress;
    }

    final paint = Paint()..color = color.withOpacity(opacity);
    final rect = Rect.fromLTWH(0, 0, _lightningWidth, size.height * progress);

    final path = Path();
    for (final p in _lightnings[lightningType]) {
      path.lineTo(_lightningWidth * p.x, size.height * p.y);
    }

    canvas.save();
    canvas.translate(index * _lightningWidth, 0);
    canvas.clipPath(path);
    canvas.drawRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_LightningPainter oldDelegate) {
    return index != oldDelegate.index ||
        color != oldDelegate.color ||
        progress != oldDelegate.progress;
  }
}
