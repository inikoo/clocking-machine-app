import 'package:ClockIN/model/clock/clock.dart';
import 'package:ClockIN/model/clock/layers/digits.dart';
// import 'package:ClockIN/model/clock/layers/mountains.dart';
// import 'package:ClockIN/model/clock/layers/sky.dart';
// import 'package:ClockIN/model/clock/layers/sky_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';

class DigitalClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Transform.scale(scale: 1.5, child: SkyGradient()),
        // Transform.scale(scale: 1.3, child: Sky()),
        // Transform.scale(
        //   scale: 1.25,
        //   child: Transform.translate(
        //     offset: Offset(0, h * 0.06),
        //     child: Mountains(),
        //   ),
        // ),
        _TimeSection(h: h, w: w),
      ],
    );
  }
}

class _TimeSection extends StatelessWidget {
  const _TimeSection({
    Key key,
    @required this.h,
    @required this.w,
  }) : super(key: key);

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    // final isDayTime = Clock.of(context).isDayTime;
    final textColor = Colors.white;
    final bottomTextStyle = TextStyle(
      color: textColor,
      fontSize: 26,
      fontFamily: 'Comfortaa',
    );

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        // isDayTime ? Colors.black :
        Colors.white,
        BlendMode.modulate,
      ),
      child: Container(
        alignment: Alignment.center,
        child: Container(
          height: h / 2.2,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              SizedBox(
                height: h / 8,
                child: Digits(digitColor: textColor),
              ),
              const SizedBox(height: 20),
              Row(
                textBaseline: TextBaseline.ideographic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Mdi.calendarMonth,
                    color: Colors.white,
                    size: 26,
                  ),
                  SizedBox(width: 8),
                  Text(
                    DateFormat('EEEE, MMMM d').format(Clock.of(context).now),
                    style: bottomTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
