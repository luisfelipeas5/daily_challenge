import 'dart:async';

import 'package:daily_challenge/shared/widgets/coin/coin.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

const double _sensorTranslateMultiplier = 10;
const _eventAnimationDuration = Duration(milliseconds: 400);

class SensorCoin extends StatefulWidget {
  final double size;

  const SensorCoin({
    super.key,
    required this.size,
  });

  @override
  State<SensorCoin> createState() => _SensorCoinState();
}

class _SensorCoinState extends State<SensorCoin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late StreamSubscription _accelerometerStreamSubscription;

  double _oldX = 0;
  double _x = 0;
  double _oldY = 0;
  double _y = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.addStatusListener(_animationControllerStatusListener);
    _accelerometerStreamSubscription =
        userAccelerometerEvents.listen(_onUserAccelerometerEventChanged);
  }

  void _animationControllerStatusListener(status) {
    if (_isFowardCompleted(status)) {
      _controller.reverse();
    }
  }

  bool _isFowardCompleted(status) =>
      status == AnimationStatus.completed && _animation.value != 0;

  void _onUserAccelerometerEventChanged(UserAccelerometerEvent event) {
    _controller.stop();

    _oldX = _currentX;
    _oldY = _currentY;

    _x = event.x * _sensorTranslateMultiplier;
    _y = event.y * _sensorTranslateMultiplier;

    _controller.reset();
    _controller.duration = _eventAnimationDuration;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Padding(
          padding: _getPadding(),
          child: child,
        );
      },
      child: Coin(size: widget.size),
    );
  }

  EdgeInsetsGeometry _getPadding() {
    return EdgeInsets.only(
      top: _movingDown ? _translateVertical : 0,
      bottom: _movingDown ? 0 : _translateVertical,
      left: _movingRight ? _translateHorizontal : 0,
      right: _movingRight ? 0 : _translateHorizontal,
    );
  }

  double get _translateVertical => _currentY.abs();

  double get _translateHorizontal => _currentX.abs();

  bool get _movingRight => _currentX > 0;

  bool get _movingDown => _currentY < 0;

  double get _currentX {
    final percent = _animation.value;
    final alphaX = percent * (_x - _oldX);
    return alphaX + _oldX;
  }

  double get _currentY {
    final percent = _animation.value;
    var alphaY = percent * (_y - _oldY);
    return alphaY + _oldY;
  }

  @override
  void dispose() {
    _accelerometerStreamSubscription.cancel();
    _controller.stop();
    super.dispose();
  }
}
