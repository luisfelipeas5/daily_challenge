import 'dart:math';

import 'package:daily_challenge/shared/widgets/coin/sensor_coin.dart';
import 'package:flutter/material.dart';

const _minAnimationDuration = Duration(milliseconds: 700);
const _randomDurationFactor = 700;

class AnimatedSensorCoin extends StatefulWidget {
  final double size;

  const AnimatedSensorCoin({
    super.key,
    required this.size,
  });

  @override
  State<AnimatedSensorCoin> createState() => _AnimatedSensorCoinState();
}

class _AnimatedSensorCoinState extends State<AnimatedSensorCoin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _animation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.bounceOut))
        .animate(_controller);
    _controller.forward();
  }

  Duration get _animationDuration {
    final randomDouble = Random().nextDouble();
    final randomMilliseconds = (_randomDurationFactor * randomDouble).toInt();
    return _minAnimationDuration + Duration(milliseconds: randomMilliseconds);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          transform: _getTransform(),
          child: child,
        );
      },
      child: SensorCoin(
        size: widget.size,
      ),
    );
  }

  Matrix4 _getTransform() => Matrix4.translationValues(
        0,
        _getCurrentTranslationY(),
        0,
      );

  double _getCurrentTranslationY() {
    const startTranslationY = -100;
    const endTranslationY = 0;
    const difference = endTranslationY - startTranslationY;
    return startTranslationY + (difference * _animation.value);
  }
}
