import 'package:daily_challenge/shared/widgets/bias_alignment/bias_alignment.dart';
import 'package:daily_challenge/shared/widgets/coin/coin.dart';
import 'package:flutter/material.dart';

class CoinsBackground extends StatelessWidget {
  final Widget child;

  const CoinsBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ..._getTopCoins(),
        ..._getBottomCoins(),
        child,
      ],
    );
  }

  List<Widget> _getTopCoins() {
    return [
      const BiasAlignment(
        horizontalBias: 0.1,
        verticalBias: 0.2,
        child: Coin(size: 52),
      ),
      const BiasAlignment(
        horizontalBias: 0.8,
        verticalBias: 0.1,
        child: Coin(size: 70),
      ),
      const BiasAlignment(
        horizontalBias: 0.2,
        verticalBias: 0.35,
        child: Coin(size: 82),
      ),
    ];
  }

  List<Widget> _getBottomCoins() {
    return [
      const BiasAlignment(
        horizontalBias: 0.08,
        verticalBias: 0.8,
        child: Coin(size: 33),
      ),
      const BiasAlignment(
        horizontalBias: 0.9,
        verticalBias: 0.75,
        child: Coin(size: 50),
      ),
    ];
  }
}
