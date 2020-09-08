import 'package:flutter/material.dart';

class AnimatedRotation extends StatelessWidget {
  const AnimatedRotation({
    Key key,
    @required this.rotation,
    @required this.duration,
    this.child,
  }) : super(key: key);

  final double rotation;
  final Duration duration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(end: rotation),
      duration: duration,
      builder: (context, rotation, child) => Transform.rotate(
        angle: rotation,
        child: child,
      ),
      child: child,
    );
  }
}
