import 'package:flutter/material.dart';

class AmbientMovement extends StatefulWidget {
  AmbientMovement({
    Key key,
    @required this.direction,
    @required this.initialPosition,
    @required this.startCoordinate,
    @required this.endCoordinate,
    @required this.duration,
    @required this.child,
  })  : assert(endCoordinate >= startCoordinate),
        super(key: key);

  final Axis direction;
  final double initialPosition;
  final double startCoordinate;
  final double endCoordinate;
  final Duration duration;
  final Widget child;

  @override
  _AmbientMovementState createState() => _AmbientMovementState();
}

class _AmbientMovementState extends State<AmbientMovement>
    with TickerProviderStateMixin<AmbientMovement> {
  AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _initAnimController();
  }

  @override
  void didUpdateWidget(AmbientMovement oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _initAnimController();
    }
  }

  void _initAnimController() {
    _ctrl?.dispose();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _ctrl.addListener(() {
      setState(() {});
    });
    _ctrl.repeat();
  }

  @override
  void dispose() {
    _ctrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pos = (widget.initialPosition + _ctrl.value) % 1.0;
    final width = widget.endCoordinate - widget.startCoordinate;
    final absPosition = pos * width + widget.startCoordinate;

    return Transform.translate(
      offset: Offset(
        widget.direction == Axis.horizontal ? absPosition : 0,
        widget.direction == Axis.vertical ? absPosition : 0,
      ),
      child: widget.child,
    );
  }
}
