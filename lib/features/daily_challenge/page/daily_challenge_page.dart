import 'package:daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/features/daily_challenge/widgets/instructions/roulette_instructions.dart';
import 'package:daily_challenge/features/daily_challenge/widgets/logo/logo.dart';
import 'package:daily_challenge/features/daily_challenge/widgets/roulette_item/roulette.dart';
import 'package:daily_challenge/features/daily_challenge/widgets/run_button/run_button.dart';
import 'package:daily_challenge/shared/widgets/coins_background/coins_background.dart';
import 'package:daily_challenge/shared/widgets/page_background/page_background.dart';
import 'package:flutter/material.dart';

class DailyChallengePage extends StatelessWidget {
  const DailyChallengePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageBackground(
        child: CoinsBackground(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(
                  child: Logo(),
                ),
                Expanded(
                  child: _buildRoulette(),
                ),
                Expanded(
                  child: _builtBottom(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Roulette _buildRoulette() {
    return const Roulette(
      rouletteItems: [
        RouletteItem(type: RouletteType.failed),
        RouletteItem(type: RouletteType.failed),
        RouletteItem(type: RouletteType.success),
      ],
    );
  }

  Widget _builtBottom() {
    return Column(
      children: const [
        RouletteInstructions(),
        SizedBox(height: 43),
        RunButton(),
      ],
    );
  }
}
