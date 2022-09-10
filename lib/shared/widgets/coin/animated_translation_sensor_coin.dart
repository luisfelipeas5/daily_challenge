import 'dart:math';

import 'package:daily_challenge/shared/widgets/coin/sensor_coin.dart';
import 'package:flutter/material.dart';

const _minAnimationDuration = Duration(milliseconds: 700);
const _randomDurationFactor = 700;
const _animationDelay = Duration(milliseconds: 1000);

class AnimatedTranslationSensorCoin extends StatefulWidget {
  final double size;
  final bool translateY;
  final bool translateZ;
  final bool delayAnimation;

  const AnimatedTranslationSensorCoin({
    super.key,
    required this.size,
    this.translateY = true,
    this.translateZ = false,
    this.delayAnimation = true,
  });

  @override
  State<AnimatedTranslationSensorCoin> createState() =>
      _AnimatedTranslationSensorCoinState();
}

class _AnimatedTranslationSensorCoinState
    extends State<AnimatedTranslationSensorCoin>
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
    _scheduleEnterAnimation();
  }

  Future<void> _scheduleEnterAnimation() async {
    if (widget.delayAnimation) await Future.delayed(_animationDelay);
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
        return Transform(
          transform: _transform,
          origin: Offset(
            widget.size / 2,
            widget.size / 2,
          ),
          child: child,
        );
      },
      child: SensorCoin(
        size: widget.size,
      ),
    );
  }

  double get _scale => _animation.value;

  Matrix4 get _transform => Matrix4.translationValues(
        0,
        widget.translateY ? _currentTranslationY : 0,
        0,
      )..scale(_scale);

  double get _currentTranslationY {
    const startTranslationY = -100;
    const endTranslationY = 0;
    const difference = endTranslationY - startTranslationY;
    return startTranslationY + (difference * _animation.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
