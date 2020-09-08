import 'package:ClockIN/model/clock/clock.dart';
import 'package:ClockIN/model/clock/digital_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:provider/provider.dart';

class HomeBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Clock(),
      child: ClockCustomizer(
        (ClockModel model) => ChangeNotifierProvider.value(
          value: model,
          child: DigitalClock(),
        ),
      ),
    );
  }
}
