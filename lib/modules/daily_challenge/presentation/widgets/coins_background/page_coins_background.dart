import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/coins_background/draggable_coin.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/coins_drag_target/coins_drag_target.dart';
import 'package:daily_challenge/shared/widgets/double_direction_alignment/double_direction_alignment.dart';
import 'package:flutter/material.dart';

class PageCoinsBackground extends StatelessWidget {
  final Widget child;

  const PageCoinsBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ..._getTopCoins(),
        ..._getBottomCoins(),
        Align(
          alignment: Alignment.center,
          child: child,
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: SpecialCoinsDragTarget(),
        ),
      ],
    );
  }

  List<Widget> _getTopCoins() {
    return [
      const DoubleDirectionAlignment(
        horizontal: 0.1,
        vertical: 0.2,
        child: DraggableCoin(size: 52),
      ),
      const DoubleDirectionAlignment(
        horizontal: 0.8,
        vertical: 0.1,
        child: DraggableCoin(size: 70),
      ),
      const DoubleDirectionAlignment(
        horizontal: 0.2,
        vertical: 0.35,
        child: DraggableCoin(size: 82),
      ),
    ];
  }

  List<Widget> _getBottomCoins() {
    return [
      const DoubleDirectionAlignment(
        horizontal: 0.08,
        vertical: 0.8,
        child: DraggableCoin(size: 33),
      ),
      const DoubleDirectionAlignment(
        horizontal: 0.9,
        vertical: 0.75,
        child: DraggableCoin(size: 50),
      ),
    ];
  }
}
