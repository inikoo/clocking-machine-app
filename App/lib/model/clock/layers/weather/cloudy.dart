import 'package:ClockIN/model/clock/elements/clouds.dart';
import 'package:flutter/material.dart';

class Cloudy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Clouds(
      type: CloudType.rain,
    );
  }
}
