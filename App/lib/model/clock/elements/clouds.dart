import 'dart:math';

import 'package:ClockIN/model/clock/elements/cloud.dart';
import 'package:ClockIN/model/clock/util/ambient_movement.dart';
import 'package:flutter/material.dart';

enum CloudType { ambient, rain, snow }

class Clouds extends StatefulWidget {
  final CloudType type;

  const Clouds({
    Key key,
    @required this.type,
  })  : assert(type != null),
        super(key: key);

  @override
  _CloudsState createState() => _CloudsState();
}

class _CloudsState extends State<Clouds> {
  final _clouds = <Widget>[];
  BoxConstraints _constraints;

  final _cloudPositions = <int, double>{};
  final _cloudDurations = <int, Duration>{};

  @override
  void didUpdateWidget(Clouds oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      _clouds.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (_constraints != constraints) {
        _clouds.clear();
        _cloudPositions.clear();
        _cloudDurations.clear();
        _buildClouds(context, constraints);
      }
      _constraints = constraints;

      return Stack(
        alignment: Alignment.topLeft,
        children: _clouds,
      );
    });
  }

  void _buildClouds(BuildContext context, BoxConstraints constraints) {
    switch (widget.type) {
      case CloudType.ambient:
        return _buildAmbientClouds(context, constraints);
      case CloudType.rain:
        return _buildHeavyClouds(
          context,
          constraints,
          lightColor: Colors.grey[100].withOpacity(0.85),
          darkColor: Colors.grey[400].withOpacity(0.85),
        );
      case CloudType.snow:
        return _buildHeavyClouds(
          context,
          constraints,
          lightColor: Colors.white.withOpacity(0.85),
          darkColor: Colors.grey[100].withOpacity(0.85),
        );
    }
  }

  void _buildAmbientClouds(BuildContext context, BoxConstraints constraints) {
    const cloudStep = 32.0;

    final rnd = Random(DateTime.now().millisecondsSinceEpoch);
    int i = 0;
    for (var y = -64.0; y < constraints.maxHeight; y += cloudStep) {
      final initialPos = _cloudPositions[i] ??= rnd.nextDouble();
      final duration =
          _cloudDurations[i] ??= Duration(seconds: rnd.nextInt(60) + 25);
      _clouds.add(
        Positioned(
          top: y,
          child: AmbientMovement(
            direction: Axis.horizontal,
            duration: duration,
            startCoordinate: -256,
            endCoordinate: constraints.maxWidth + 256,
            initialPosition: initialPos,
            child: SizedBox(
              width: 256,
              height: 128,
              child: Cloud(
                typeIndex: (y ~/ cloudStep) % 4,
                minScale: rnd.nextDouble() * 0.35 + 0.15,
                maxScale: rnd.nextDouble() * 0.25 + 0.25,
                lightColor: Colors.white.withOpacity(0.5),
                darkColor: Colors.grey[50].withOpacity(0.5),
                animationDuration:
                    Duration(milliseconds: 1500 + rnd.nextInt(1000)),
                animationStartDelay: Duration(milliseconds: rnd.nextInt(2000)),
              ),
            ),
          ),
        ),
      );
      i++;
    }
  }

  void _buildHeavyClouds(
    BuildContext context,
    BoxConstraints constraints, {
    @required Color lightColor,
    @required Color darkColor,
  }) {
    const cloudStep = 32.0;

    final rnd = Random(DateTime.now().millisecondsSinceEpoch);
    for (var x = -256.0; x < constraints.maxWidth; x += cloudStep) {
      _clouds.add(
        Positioned(
          left: x,
          top: (rnd.nextDouble() - 1.25) * 64,
          child: SizedBox(
            width: 256,
            height: 128,
            child: Cloud(
              typeIndex: (x ~/ cloudStep) % 4,
              minScale: rnd.nextDouble() * 0.25 + 0.5,
              maxScale: rnd.nextDouble() * 0.25 + 0.75,
              lightColor: lightColor,
              darkColor: darkColor,
              animationDuration:
                  Duration(milliseconds: 1500 + rnd.nextInt(1000)),
              animationStartDelay: Duration(milliseconds: rnd.nextInt(2000)),
            ),
          ),
        ),
      );
    }
  }
}
