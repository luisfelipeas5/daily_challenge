import 'package:daily_challenge/shared/widgets/coin/coin.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

const double sensorTranslateMultiplier = 5;

class SensorCoin extends StatelessWidget {
  final double size;

  const SensorCoin({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserAccelerometerEvent>(
      stream: userAccelerometerEvents,
      builder: (context, snapshot) {
        final sensorEvent = snapshot.data;
        return Padding(
          padding: _getAccelerometerPadding(sensorEvent),
          child: Coin(size: size),
        );
      },
    );
  }

  EdgeInsetsGeometry _getAccelerometerPadding(
    UserAccelerometerEvent? sensorEvent,
  ) {
    if (sensorEvent == null) return const EdgeInsets.all(0);

    final x = sensorEvent.x * sensorTranslateMultiplier;
    final movingRight = x > 0;

    final y = sensorEvent.y * sensorTranslateMultiplier;
    final movingDown = y < 0;

    return EdgeInsets.only(
      top: movingDown ? -y : 0,
      bottom: movingDown ? 0 : y,
      left: movingRight ? x : 0,
      right: movingRight ? 0 : -x,
    );
  }
}
