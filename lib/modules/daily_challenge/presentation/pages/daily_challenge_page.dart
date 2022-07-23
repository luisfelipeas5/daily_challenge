import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/instructions/roulette_instructions.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/logo/logo.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/daily_challenge_roulette.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/spin_button/spin_button.dart';
import 'package:daily_challenge/shared/widgets/coins_background/coins_background.dart';
import 'package:daily_challenge/shared/widgets/page_background/page_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyChallengePage extends StatefulWidget {
  const DailyChallengePage({
    super.key,
  });

  @override
  State<DailyChallengePage> createState() => _DailyChallengePageState();
}

class _DailyChallengePageState extends State<DailyChallengePage> {
  DailyChallengeBloc get _bloc => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    _bloc.add(DailyChallengeLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageBackground(
        child: CoinsBackground(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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

  Widget _buildRoulette() {
    return const DailyChallengeRoulette();
  }

  Widget _builtBottom() {
    return Column(
      children: const [
        RouletteInstructions(),
        SizedBox(height: 43),
        SpinButton(),
      ],
    );
  }
}
