import 'dart:math';

import 'package:ClockIN/model/clock/clock.dart';
import 'package:ClockIN/model/clock/util/animated_rotation.dart';
import 'package:ClockIN/model/clock/util/weather_particle_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

const kSunSize = 120.0;

class Sun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sun = AnimatedRotation(
      rotation: -Clock.of(context).sunPosition,
      duration: Clock.of(context).updateRate,
      child: Container(
        width: kSunSize,
        height: kSunSize,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow.shade600, Colors.yellow.shade900],
          ),
          shape: CircleBorder(),
        ),
      ),
    );

    if (ClockExtra.of(context).weatherCondition == WeatherCondition.sunny) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            width: kSunSize,
            height: kSunSize,
            child: WeatherParticleAnimator(
              axis: Axis.vertical,
              amount: _raysAmount,
              minAnimDuration: const Duration(milliseconds: 600),
              maxAnimDuration: const Duration(milliseconds: 800),
              minAnimDelay: const Duration(milliseconds: 400),
              maxAnimDelay: const Duration(milliseconds: 500),
              particleBuilder: (index, color, progress) => _SunlightPainter(
                index: index,
                color: color,
                progress: progress,
                isDayTime: Clock.of(context).isDayTime,
              ),
            ),
          ),
          sun,
        ],
      );
    } else {
      return sun;
    }
  }
}

const _rayWidth = 8.0;
const _rayHeight = _rayWidth * 5;
const _raysAmount = 20;

class _SunlightPainter extends CustomPainter {
  _SunlightPainter({
    @required this.index,
    @required this.color,
    @required this.progress,
    @required this.isDayTime,
  });

  final int index;
  final Color color;
  final double progress;
  final bool isDayTime;

  @override
  void paint(Canvas canvas, Size size) {
    if (!isDayTime) return;

    double opacity;
    if (progress < 0.5) {
      opacity = progress;
    } else {
      opacity = 1 - progress;
    }

    final paint = Paint()..color = Colors.yellow.shade600.withOpacity(opacity);
    final rect = RRect.fromLTRBR(
        0, 0, _rayWidth, _rayHeight * progress, Radius.circular(_rayWidth / 2));

    final angle = 2 * pi / _raysAmount * index;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(angle);
    canvas.translate(0, kSunSize / 2 + kSunSize / 8);
    canvas.drawRRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_SunlightPainter oldDelegate) {
    return index != oldDelegate.index ||
        color != oldDelegate.color ||
        progress != oldDelegate.progress ||
        isDayTime != oldDelegate.isDayTime;
  }
}
