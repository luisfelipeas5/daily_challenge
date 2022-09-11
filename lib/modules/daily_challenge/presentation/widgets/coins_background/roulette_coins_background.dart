import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/coins_background/draggable_coin.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/coins_drag_target/coins_drag_target.dart';
import 'package:daily_challenge/shared/widgets/double_direction_alignment/double_direction_alignment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouletteCoinsBackground extends StatelessWidget {
  final Widget child;

  const RouletteCoinsBackground({
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
      DoubleDirectionAlignment(
        horizontal: 0.1,
        vertical: 0.2,
        child: _buildCoin(size: 52),
      ),
      DoubleDirectionAlignment(
        horizontal: 0.4,
        vertical: 0.23,
        child: _buildCoin(size: 52),
      ),
      DoubleDirectionAlignment(
        horizontal: 0.8,
        vertical: 0.1,
        child: _buildCoin(size: 70),
      ),
      DoubleDirectionAlignment(
        horizontal: 0.2,
        vertical: 0.35,
        child: _buildCoin(size: 82),
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

  Widget _buildCoin({required double size}) {
    return BlocBuilder<RouletteBloc, RouletteState>(
      buildWhen: (previous, current) =>
          previous.coinsShaking != current.coinsShaking,
      builder: (context, state) {
        return DraggableCoin(
          size: size,
          shaking: state.coinsShaking,
        );
      },
    );
  }
}
