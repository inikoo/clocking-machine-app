import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ParticlePainterBuilder = CustomPainter Function(
    int index, Color color, double animationProgress);

class WeatherParticleAnimator extends StatelessWidget {
  const WeatherParticleAnimator({
    Key key,
    @required this.axis,
    @required this.particleBuilder,
    this.step,
    this.amount,
    this.minAnimDuration = const Duration(seconds: 4),
    this.maxAnimDuration = const Duration(seconds: 6),
    this.minAnimDelay = const Duration(),
    this.maxAnimDelay = const Duration(),
  })  : assert(
            step == null && amount != null || step != null && amount == null),
        assert(minAnimDuration != null && maxAnimDuration != null),
        assert(minAnimDelay != null && maxAnimDelay != null),
        super(key: key);

  final ParticlePainterBuilder particleBuilder;
  final Axis axis;
  final double step;
  final int amount;
  final Duration minAnimDuration;
  final Duration maxAnimDuration;
  final Duration minAnimDelay;
  final Duration maxAnimDelay;

  @override
  Widget build(BuildContext context) {
    if (amount != null) {
      return Stack(
        children: List.generate(
          amount,
          (i) => _Particle(
            index: i,
            particleBuilder: particleBuilder,
            minAnimDuration: minAnimDuration,
            maxAnimDuration: maxAnimDuration,
            minAnimDelay: minAnimDelay,
            maxAnimDelay: maxAnimDelay,
          ),
        ),
      );
    } else {
      assert(step != null);
      return LayoutBuilder(
        builder: (context, constraints) {
          final particles = <Widget>[];
          final maxDimen = constraints.maxWidth;
          for (var i = 0.0; i < maxDimen; i += step) {
            particles.add(
              _Particle(
                index: i ~/ step,
                particleBuilder: particleBuilder,
                minAnimDuration: minAnimDuration,
                maxAnimDuration: maxAnimDuration,
                minAnimDelay: minAnimDelay,
                maxAnimDelay: maxAnimDelay,
              ),
            );
          }

          return Stack(
            children: particles,
          );
        },
      );
    }
  }
}

class _Particle extends StatefulWidget {
  const _Particle({
    Key key,
    @required this.index,
    @required this.particleBuilder,
    @required this.minAnimDuration,
    @required this.maxAnimDuration,
    @required this.minAnimDelay,
    @required this.maxAnimDelay,
  })  : assert(minAnimDuration <= maxAnimDuration),
        assert(minAnimDelay <= maxAnimDelay),
        super(key: key);

  final int index;
  final ParticlePainterBuilder particleBuilder;
  final Duration minAnimDuration;
  final Duration maxAnimDuration;
  final Duration minAnimDelay;
  final Duration maxAnimDelay;

  @override
  _ParticleState createState() => _ParticleState();
}

class _ParticleState extends State<_Particle>
    with TickerProviderStateMixin<_Particle> {
  AnimationController _ctrl;
  Random _rnd;

  @override
  void initState() {
    super.initState();
    _rnd = Random(widget.index);
    _ctrl = AnimationController(vsync: this);
    _ctrl.addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        _runAnimation();
      }
    });
    _initAnimController();
    _runAnimation();
  }

  void _initAnimController() {
    final durationDiff = widget.maxAnimDuration - widget.minAnimDuration;
    _ctrl.duration = Duration(
      milliseconds: widget.minAnimDuration.inMilliseconds +
          _rnd.nextInt(durationDiff.inMilliseconds + 1),
    );
  }

  void _runAnimation() async {
    final delayDiff = widget.maxAnimDelay - widget.minAnimDelay;
    final delay = (_rnd.nextDouble() * delayDiff.inMicroseconds).toInt();
    await Future.delayed(Duration(microseconds: delay));
    if (_ctrl != null) {
      _ctrl.forward(from: 0);
    }
  }

  @override
  void didUpdateWidget(_Particle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index ||
        oldWidget.minAnimDuration != widget.minAnimDuration ||
        oldWidget.maxAnimDuration != widget.maxAnimDuration ||
        oldWidget.minAnimDelay != widget.minAnimDelay ||
        oldWidget.maxAnimDelay != widget.maxAnimDelay) {
      _initAnimController();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _ctrl = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anim = _ctrl.drive(
      CurveTween(curve: Curves.easeInOut),
    );
    return LayoutBuilder(
      builder: (_, constraints) => AnimatedBuilder(
        animation: anim,
        builder: (context, _) => CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter:
              widget.particleBuilder(widget.index, Colors.white, anim.value),
        ),
      ),
    );
  }
}
