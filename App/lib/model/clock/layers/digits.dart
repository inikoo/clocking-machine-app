import 'package:ClockIN/model/clock/clock.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Digits extends StatelessWidget {
  const Digits({
    Key key,
    @required this.digitColor,
  }) : super(key: key);

  final Color digitColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dateTime = Clock.of(context).now;
        final is24HourFormat = ClockExtra.of(context).is24HourFormat;

        final hour = DateFormat(is24HourFormat ? 'HH' : 'hh').format(dateTime);
        final minute = DateFormat('mm').format(dateTime);
        final second = DateFormat('ss').format(dateTime);

        final digits = <int>[
          int.parse(hour[0]),
          int.parse(hour[1]),
          int.parse(minute[0]),
          int.parse(minute[1]),
          int.parse(second[0]),
          int.parse(second[1]),
        ];

        final digitWidth = constraints.maxWidth / 12;
        final digitHeight = constraints.maxHeight;

        final secondDigitWidth = digitWidth / 4;
        final secondDigitHeight = digitHeight / 4;

        final tickerWidth = 8 * digitWidth / 12;

        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[0], color: digitColor),
            ),
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[1], color: digitColor),
            ),
            SizedBox(
              width: tickerWidth,
              height: digitHeight,
              child: _Ticker(color: digitColor),
            ),
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[2], color: digitColor),
            ),
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[3], color: digitColor),
            ),
            Column(
              children: <Widget>[
                Expanded(child: _AmPmIndicator(color: digitColor)),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: secondDigitWidth,
                      height: secondDigitHeight,
                      child: _Digit(digit: digits[4], color: digitColor),
                    ),
                    SizedBox(
                      width: secondDigitWidth,
                      height: secondDigitHeight,
                      child: _Digit(digit: digits[5], color: digitColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _AmPmIndicator extends StatelessWidget {
  const _AmPmIndicator({
    Key key,
    @required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Clock.of(context).updateRate,
      child: Center(
        child: Text(
          DateFormat('a').format(Clock.of(context).now),
          style: TextStyle(
            fontFamily: 'RussoOne',
            fontSize: 23,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _Digit extends StatefulWidget {
  const _Digit({
    Key key,
    @required this.digit,
    this.color,
    this.callback,
  }) : super(key: key);

  final int digit;
  final Color color;
  final Function(String) callback;

  @override
  _DigitState createState() => _DigitState();
}

class _DigitState extends State<_Digit> {
  int _prevDigit;

  @override
  void didUpdateWidget(_Digit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.digit != widget.digit) {
      _prevDigit = oldWidget.digit;
    }
  }

  @override
  Widget build(BuildContext context) {
    final animation = _prevDigit != null
        ? '$_prevDigit -> ${widget.digit}'
        : '${(widget.digit - 1) % 10} -> ${widget.digit}';

    return KeyedSubtree(
      key: ValueKey<int>(widget.digit),
      child: FlareActor(
        'assets/animate/numbers.flr',
        artboard: 'Anim',
        animation: animation,
        alignment: Alignment.center,
        fit: BoxFit.contain,
        callback: widget.callback,
        color: widget.color,
      ),
    );
  }
}

class _Ticker extends StatelessWidget {
  const _Ticker({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return FlareActor(
      'assets/animate/numbers.flr',
      artboard: 'Ticker',
      animation: 'tick',
      alignment: Alignment.center,
      fit: BoxFit.contain,
      color: color,
    );
  }
}
