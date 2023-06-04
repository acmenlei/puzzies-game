import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final int value;
  final Duration duration;
  const AnimatedCounter(
      {super.key, required this.value, required this.duration});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(end: value.toDouble()),
      duration: duration,
      builder: (context, value, child) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        return Stack(children: [
          Positioned(
              top: -100 * decimal,
              child: AnimatedOpacity(
                duration: duration,
                opacity: 1.0 - decimal,
                child: Text(
                  '$whole',
                  style: const TextStyle(fontSize: 100),
                ),
              )),
          Positioned(
              top: 100 - 100 * decimal,
              child: AnimatedOpacity(
                duration: duration,
                opacity: decimal,
                child: Text(
                  '${whole + 1}',
                  style: const TextStyle(fontSize: 100),
                ),
              ))
        ]);
      },
    );
  }
}
