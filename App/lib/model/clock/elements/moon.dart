import 'package:ClockIN/model/clock/clock.dart';
import 'package:ClockIN/model/clock/util/animated_rotation.dart';
import 'package:flutter/material.dart';

const kMoonSize = 120.0;

class Moon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      rotation: -Clock.of(context).moonPosition.abs(),
      duration: Clock.of(context).updateRate,
      child: Stack(
        children: <Widget>[
          Container(
            width: kMoonSize,
            height: kMoonSize,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade50, Colors.grey.shade400],
              ),
              shape: const CircleBorder(),
            ),
          ),
          Positioned(
            top: 30,
            left: 20,
            width: 16,
            height: 16,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 30,
            width: 32,
            height: 32,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 70,
            width: 24,
            height: 24,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
            ),
          ),
          Positioned(
            top: 24,
            left: 50,
            width: 12,
            height: 12,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 80,
            width: 18,
            height: 18,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
