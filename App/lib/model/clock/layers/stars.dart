import 'dart:math';

import 'package:ClockIN/model/clock/elements/star.dart';
import 'package:flutter/material.dart';

final _rnd = Random(DateTime.now().millisecondsSinceEpoch);

const _starsAmount = 200;

final _starOffsets = List.generate(
  _starsAmount,
  (_) => Offset(_rnd.nextDouble(), _rnd.nextDouble() * 2 - 0.5),
);

final _starSizes = List.generate(
  _starsAmount,
  (_) => _rnd.nextDouble() * 0.5 + 0.5,
);

final _starOpacities = List.generate(
  _starsAmount,
  (_) => _rnd.nextDouble() * 0.5 + 0.5,
);

final _starRotations = List.generate(
  _starsAmount,
  (_) => _rnd.nextDouble() * pi,
);

class Stars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        overflow: Overflow.visible,
        children: List.generate(
          _starsAmount,
          (i) => Positioned(
            left: constraints.maxWidth * _starOffsets[i].dx,
            top: constraints.maxHeight * _starOffsets[i].dy,
            width: 24 * _starSizes[i],
            height: 24 * _starSizes[i],
            child: Transform.rotate(
              angle: _starRotations[i],
              child: Star(
                color: Colors.white.withOpacity(_starOpacities[i]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
