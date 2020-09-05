import 'package:ClockIN/model/clock/clock.dart';
import 'package:flutter/material.dart';

const _earlyMorning = [
  Color(0xff172380),
  Color(0xff40227c),
  Color(0xff5c2378),
  Color(0xff702276),
  Color(0xffa5436b),
  Color(0xff7c2470),
  Color(0xff872768),
  Color(0xff9c2a5e),
  Color(0xffa85d64),
  Color(0xffa55467),
  Color(0xffa74f69),
  Color(0xffa43961),
  Color(0xffa5395e),
  Color(0xffa73659),
  Color(0xff9f2c5b),
  Color(0xffab2d54),
];

const _midMorning = [
  Color(0xff1f2ee4),
  Color(0xff6b2dd9),
  Color(0xff972dcd),
  Color(0xff9c2dcc),
  Color(0xffce62b2),
  Color(0xffc63b96),
  Color(0xffc43a9b),
  Color(0xffab31bb),
  Color(0xffd394a5),
  Color(0xffcd83aa),
  Color(0xffd07ead),
  Color(0xffce529f),
  Color(0xffd0519b),
  Color(0xffd14f96),
  Color(0xffd54283),
  Color(0xffc63b95),
];

const _lateMorning = [
  Color(0xff47b7ff),
  Color(0xff6eb6ff),
  Color(0xff47b9ff),
  Color(0xff79bcff),
  Color(0xff8dc3fc),
  Color(0xffd8b9ff),
  Color(0xff90c5fa),
  Color(0xffd8b7ff),
  Color(0xffa1cbf3),
  Color(0xffa1ccef),
  Color(0xff9fcaf9),
  Color(0xffd8baf8),
  Color(0xffaad0eb),
  Color(0xffaed4e8),
  Color(0xffacd1ed),
  Color(0xffeddbf9),
];

const _earlyAfternoon = [
  Color(0xff66dbff),
  Color(0xff6bddff),
  Color(0xff75e0ff),
  Color(0xff6fdeff),
  Color(0xff76e0ff),
  Color(0xff7ee2ff),
  Color(0xff87e4ff),
  Color(0xff89e5ff),
  Color(0xff8ae5ff),
  Color(0xff8fe6ff),
  Color(0xff93e7ff),
  Color(0xff98e8ff),
  Color(0xff9feaff),
  Color(0xffaeeeff),
  Color(0xffa3ebff),
  Color(0xffadeeff),
];

const _midAfternoon = [
  Color(0xff73e0ff),
  Color(0xff76e1ff),
  Color(0xff78e2ff),
  Color(0xff82e5ff),
  Color(0xff81e5ff),
  Color(0xff88e6ff),
  Color(0xff95e9ff),
  Color(0xff96e9ff),
  Color(0xff97e9ff),
  Color(0xff98e9ff),
  Color(0xffa4ecff),
  Color(0xffabedff),
  Color(0xffa9edff),
  Color(0xffaaedff),
  Color(0xffb7f1ff),
  Color(0xffdffaff),
];

const _lateAfternoon = [
  Color(0xff65dbff),
  Color(0xff66dbff),
  Color(0xff75e0ff),
  Color(0xff73dfff),
  Color(0xff8ae5ff),
  Color(0xff8be5ff),
  Color(0xff87e4ff),
  Color(0xffa0eaff),
  Color(0xffa1ebff),
  Color(0xff9eeaff),
  Color(0xff9feaff),
  Color(0xffadeeff),
  Color(0xffcadeff),
  Color(0xffccdcff),
  Color(0xffd8dbff),
  Color(0xffd8dcff),
];

const _earlyEvening = [
  Color(0xff4874e5),
  Color(0xff6071e3),
  Color(0xff7f74d9),
  Color(0xff8b77d0),
  Color(0xff947ec6),
  Color(0xff9a8abd),
  Color(0xff9b8cbc),
  Color(0xff9796c1),
  Color(0xff9da2c9),
  Color(0xffa5aed7),
  Color(0xff9f8fba),
  Color(0xff9e92ba),
  Color(0xff9f91b9),
  Color(0xffb0bddd),
  Color(0xffaec2de),
  Color(0xffb5cedf),
];

const _midEvening = [
  Color(0xff8e1c7a),
  Color(0xff881e88),
  Color(0xff9a195d),
  Color(0xffa11951),
  Color(0xffc31e4a),
  Color(0xffc11d4a),
  Color(0xffd2253e),
  Color(0xffd5214b),
  Color(0xffcc683a),
  Color(0xffe67942),
  Color(0xfff9773e),
  Color(0xffd54e2a),
  Color(0xffd53e28),
  Color(0xffd53a2a),
  Color(0xffd32d30),
  Color(0xffd22e30),
];

const _earlyNight = [
  Color(0xff1e1171),
  Color(0xff201171),
  Color(0xff221171),
  Color(0xff24146d),
  Color(0xff38136f),
  Color(0xff412b77),
  Color(0xff341561),
  Color(0xff432f77),
  Color(0xff3b1d62),
  Color(0xff391c61),
  Color(0xff391f61),
  Color(0xff3b1b60),
  Color(0xff392464),
  Color(0xff392463),
  Color(0xff3b1d61),
  Color(0xff57246b),
];

const _midNight = [
  Color(0xff231968),
  Color(0xff221a64),
  Color(0xff221a61),
  Color(0xff291b5e),
  Color(0xff231a5e),
  Color(0xff221a5b),
  Color(0xff201958),
  Color(0xff271b58),
  Color(0xff1f1a53),
  Color(0xff261b53),
  Color(0xff1f1a51),
  Color(0xff1f194f),
  Color(0xff291d51),
  Color(0xff291d50),
  Color(0xff271c4a),
  Color(0xff271b46),
];

const _lateNight = [
  Color(0xff2c1e69),
  Color(0xff221e67),
  Color(0xff2d1d6b),
  Color(0xff291e67),
  Color(0xff381e6c),
  Color(0xff371e6b),
  Color(0xff391e66),
  Color(0xff3b1f66),
  Color(0xff3d2063),
  Color(0xff3d235e),
  Color(0xff3b235c),
  Color(0xff39255a),
  Color(0xff352658),
  Color(0xff2b2650),
  Color(0xff28274f),
  Color(0xff22294f),
];

final Map<Duration, List<Color>> _colorsByTime = {
  Duration(hours: 0, minutes: 0): _midNight,
  Duration(hours: 1, minutes: 0): _lateNight,
  Duration(hours: 3, minutes: 30): _earlyMorning,
  Duration(hours: 5, minutes: 0): _midMorning,
  Duration(hours: 7, minutes: 30): _lateMorning,
  Duration(hours: 12, minutes: 0): _earlyAfternoon,
  Duration(hours: 13, minutes: 0): _midAfternoon,
  Duration(hours: 14, minutes: 0): _lateAfternoon,
  Duration(hours: 15, minutes: 30): _earlyEvening,
  Duration(hours: 17, minutes: 0): _midEvening,
  Duration(hours: 19, minutes: 30): _earlyNight,
  Duration(hours: 21, minutes: 30): _midNight,
};

List<List<Color>> _cachedColors;

List<List<Color>> get _colors {
  if (_cachedColors != null) return _cachedColors;

  final result = <List<Color>>[];

  const step = Duration(minutes: 1);

  var currKeypoint = Duration();
  while (currKeypoint < const Duration(days: 1)) {
    final prevKeypoint = _colorsByTime.keys.lastWhere(
      (k) => k <= currKeypoint,
    );
    final nextKeypoint = _colorsByTime.keys.firstWhere(
      (k) => k > currKeypoint,
      orElse: () => _colorsByTime.keys.first,
    );
    final section = (nextKeypoint - prevKeypoint).inMilliseconds;
    final progress = (currKeypoint - prevKeypoint).inMilliseconds;
    final normalizedProgress = progress / section;

    final prevColors = _colorsByTime[prevKeypoint];
    final nextColors = _colorsByTime[nextKeypoint];

    final currColors = <Color>[];
    for (int i = 0; i < prevColors.length; i++) {
      final interpolatedColor =
          Color.lerp(prevColors[i], nextColors[i], normalizedProgress);
      currColors.add(interpolatedColor);
    }

    result.add(currColors);

    currKeypoint += step;
  }

  _cachedColors = result.map((c) => [c[0], c[15]]).toList();

  return _cachedColors;
}

class SkyGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = Clock.of(context).now;
    final timeUpdateRate = Clock.of(context).updateRate;

    const secondsInDay = 24 * 60 * 60;

    final nowSeconds = now.hour * 60 * 60 + now.minute * 60 + now.second;

    final partOfDayLengthSec = secondsInDay / _colors.length;
    final partOfDay = nowSeconds ~/ partOfDayLengthSec;
    final partOfPartOfDay =
        (nowSeconds - partOfDay * partOfDayLengthSec) / partOfDayLengthSec;

    final partOfDayColorsLen = _colors[0].length;

    final interpolatedColors = <Color>[];
    final interpolatedStops = <double>[];
    for (int i = 0; i < partOfDayColorsLen; i++) {
      final c = Color.lerp(_colors[partOfDay][i],
          _colors[(partOfDay + 1) % _colors.length][i], partOfPartOfDay);
      interpolatedColors.add(c);
      if (i < partOfDayColorsLen - 1) {
        interpolatedStops.add(1 / partOfDayColorsLen * i);
      }
    }
    interpolatedStops.add(1.0);

    return AnimatedContainer(
      duration: timeUpdateRate,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: interpolatedColors,
          stops: interpolatedStops,
        ),
      ),
    );
  }
}
