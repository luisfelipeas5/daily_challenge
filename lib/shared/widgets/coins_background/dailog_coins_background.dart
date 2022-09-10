import 'package:daily_challenge/shared/widgets/coin/animated_translation_sensor_coin.dart';
import 'package:daily_challenge/shared/widgets/double_direction_alignment/double_direction_alignment.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

class DialogCoinsBackground extends SingleChildStatelessWidget {
  const DialogCoinsBackground({
    super.key,
    super.child,
  });

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Stack(
      children: [
        ..._getTopCoins(),
        ..._getBottomCoins(),
        Align(
          alignment: Alignment.center,
          child: child,
        ),
      ],
    );
  }

  List<Widget> _getTopCoins() {
    return [
      DoubleDirectionAlignment(
        horizontal: 0.2,
        vertical: 0.3,
        child: _buildCoin(size: 72),
      ),
      DoubleDirectionAlignment(
        horizontal: 0.8,
        vertical: 0.15,
        child: _buildCoin(size: 106),
      ),
    ];
  }

  List<Widget> _getBottomCoins() {
    return [
      DoubleDirectionAlignment(
        horizontal: 0.08,
        vertical: 0.8,
        child: _buildCoin(size: 33),
      ),
      DoubleDirectionAlignment(
        horizontal: 0.9,
        vertical: 0.75,
        child: _buildCoin(size: 50),
      ),
    ];
  }

  AnimatedTranslationSensorCoin _buildCoin({
    required double size,
  }) {
    return AnimatedTranslationSensorCoin(
      size: size,
      delayAnimation: false,
    );
  }
}
