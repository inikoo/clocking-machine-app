import 'package:ClockIN/model/clock/layers/weather/cloudy.dart';
import 'package:ClockIN/model/clock/layers/weather/foggy.dart';
import 'package:ClockIN/model/clock/layers/weather/rainy.dart';
import 'package:ClockIN/model/clock/layers/weather/snowy.dart';
import 'package:ClockIN/model/clock/layers/weather/sunny.dart';
import 'package:ClockIN/model/clock/layers/weather/thunderstorm.dart';
import 'package:ClockIN/model/clock/layers/weather/windy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class Weather extends StatelessWidget {
  final WeatherCondition weatherCondition;

  const Weather({
    Key key,
    @required this.weatherCondition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBackground(weatherCondition);
  }
}

Widget _buildBackground(WeatherCondition weatherCondition) {
  switch (weatherCondition) {
    case WeatherCondition.cloudy:
      return Cloudy();
    case WeatherCondition.foggy:
      return Foggy();
    case WeatherCondition.rainy:
      return RainyWithClouds();
    case WeatherCondition.snowy:
      return Snowy();
    case WeatherCondition.sunny:
      return Sunny();
    case WeatherCondition.thunderstorm:
      return Thunderstorm();
    case WeatherCondition.windy:
      return Windy();
  }
  return const SizedBox.shrink();
}
